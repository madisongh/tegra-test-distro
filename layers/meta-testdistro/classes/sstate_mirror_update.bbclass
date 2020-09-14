UPDATE_SSTATE_MIRROR ?= "0"
UPDATE_DOWNLOADS_MIRROR ?= "0"

python sstate_mirror_update() {
    import os, shutil
    if d.getVar('SSTATE_SKIP_CREATION') == '1':
        return
    mirrordir = d.getVar("SSTATE_MIRRORDIR")
    if mirrordir.startswith("file://"):
        mirrordir = mirrordir[7:] # skipping over the file:// prefix, checked for below
        sstatepkg = d.getVar("SSTATE_PKG")
        mirrorpkg = os.path.join(mirrordir, d.getVar("SSTATE_PKGNAME"))
        bb.utils.mkdirhier(os.path.dirname(mirrorpkg))
        lf = bb.utils.lockfile("%s.lock" % mirrorpkg)
        try:
            bb.debug(1, "copying: %s -> %s" % (sstatepkg, mirrorpkg))
            shutil.copyfile(sstatepkg, mirrorpkg)
            shutil.copyfile(sstatepkg + ".siginfo", mirrorpkg + ".siginfo")
        except IOError:
            bb.warn("error copying %s to %s" % (sstatepkg, mirrorpkg))
        bb.utils.unlockfile(lf)
    elif mirrordir.startswith("s3://"):
        from oeaws import s3session
        # skip over the s3:// prefix
        mirrorpath = mirrordir[5:].split('/')
        mirrorpath.append(d.getVar("SSTATE_PKGNAME"))
        sstatepkg = d.getVar("SSTATE_PKG")
        destobj = '/'.join(mirrorpath[1:])
        s3 = s3session.S3Session()
        s3.upload(sstatepkg, mirrorpath[0], destobj)
        s3.upload(sstatepkg + ".siginfo", mirrorpath[0], destobj + ".siginfo")
    else:
        bb.warn("unsupported SSTATE_MIRRORDIR type: %s" % mirrodir)
}

python downloads_mirror_update() {
    import os, shutil
    src_uri = d.getVar("SRC_URI").split()
    if len(src_uri) == 0:
        return
    mirrordir = d.getVar("DOWNLOADS_MIRRORDIR")
    s3 = None
    if mirrordir.startswith("s3://"):
        from oeaws import s3session
        s3 = s3session.S3Session()
    elif not mirrordir.startswith("file://"):
        bb.warn("unsupported DOWNLOADS_MIRROR type: %s" % mirrordir)
        return
    fetcher = bb.fetch2.Fetch(src_uri, d)
    dl_dir = d.getVar("DL_DIR")
    for url in src_uri:
        if url.startswith("file://"):
            continue
        if hasattr(fetcher.ud[url], 'fullmirror'):
            localfile = fetcher.ud[url].fullmirror
        else:
            localfile = fetcher.localpath(url)
        if not os.path.exists(localfile) or os.path.isdir(localfile):
            continue
        remotefile = localfile[len(dl_dir)+1:]
        if not s3:
            if os.path.islink(localfile):
                continue
            dlmirror = mirrordir[7:]
            mirrorfile = os.path.join(dlmirror, remotefile)
            bb.utils.mkdirhier(os.path.dirname(mirrorfile))
            lf = bb.utils.lockfile("%s.lock" % mirrorfile)
            try:
                bb.debug(1, "copying: %s -> %s" % (localfile, mirrorfile))
                shutil.copyfile(localfile, mirrorfile)
            except IOError:
                bb.warn("error copying %s to %s" % (localfile, mirrorfile))
            bb.utils.unlockfile(lf)
        else:
            mirrorpath = mirrordir[5:].split('/')
            mirrorpath.append(remotefile)
            destobj = '/'.join(mirrorpath[1:])
            info = s3.get_object_info(mirrorpath[0], destobj)
            if info and 'LastModified' in info:
                mtime = int(time.mktime(info['LastModified'].timetuple()))
                st = os.stat(localfile)
                if info['ContentLength'] == st.st_size and int(st.st_mtime) == mtime:
                    continue
            s3.upload(localfile, mirrorpath[0], destobj)
}

python () {
    import os
    try:
        from oeaws import s3session
    except ImportError:
        pass
    if bb.utils.to_boolean(d.getVar("UPDATE_SSTATE_MIRROR")):
        mirrordir = d.getVar("SSTATE_MIRRORDIR")
        skip = False
        if not mirrordir:
            bb.debug(2, "SSTATE_MIRRORDIR not defined, skipping update")
            skip = True
        if not skip and mirrordir.startswith("file://"):
            if not os.access(mirrordir[7:], os.W_OK):
                bb.debug(2, "SSTATE_MIRRORDIR not writable, skipping updates")
                skip = True
        elif not skip and mirrordir.startswith("s3://"):
            if not s3session:
                bb.debug(1, "could not import oeaws.s3session, skipping updates")
                skip = True
        elif not skip:
            bb.debug(2, "SSTATE_MIRRORDIR not file:// or s3:// URL, skipping updates")
            skip = True
        if not skip:
            for task in (d.getVar("SSTATETASKS") or "").split():
                postfuncs = (d.getVarFlag(task, "postfuncs") or "").split()
                if "sstate_task_postfunc" in postfuncs and "sstate_mirror_update" not in postfuncs:
                    d.appendVarFlag(task, "postfuncs", " sstate_mirror_update")
                    d.appendVarFlag(task, "vardepsexclude", " sstate_mirror_update")

    if bb.utils.to_boolean(d.getVar("UPDATE_DOWNLOADS_MIRROR")):
        mirrordir = d.getVar("DOWNLOADS_MIRRORDIR")
        skip = False
        if not mirrordir:
            bb.debug(2, "DOWNLOADS_MIRRORDIR not defined, skipping update")
            skip = True
        if not skip and mirrordir.startswith("file://"):
            if not os.access(mirrordir[7:], os.W_OK):
                bb.debug(2, "DOWNLOADS_MIRRORDIR not writable, skipping updates")
                skip = True
        elif not skip and mirrordir.startswith("s3://"):
            if not s3session:
                bb.debug(1, "could not import oeaws.s3session, skipping updates")
                skip = True
        elif not skip:
            bb.debug(2, "DOWNLOADS_MIRRORDIR not file:// or s3:// URL, skipping updates")
            skip = True
        if not skip:
            postfuncs = (d.getVarFlag("do_fetch", "postfuncs") or "").split()
            if "downloads_mirror_update" not in postfuncs:
                d.appendVarFlag("do_fetch", "postfuncs", " downloads_mirror_update")
                d.appendVarFlag("do_fetch", "vardepsexclude", " downloads_mirror_update")
}

