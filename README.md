# Ops-Trust Platform - openid

This is the code that runs [Ops-Trust](https://openid.ops-trust.net).

It is placed under the [Apache Version 2.0 License](http://www.apache.org/licenses/).

There is a short [installation text](INSTALL.md) which describes prerequisites.
Proper packaging for both FreeBSD and Debian are following.

## Installation Requirements
The Ops-T Database permission architecture has the following invariants:

* database setup per the ops-trust portal project (https://github.com/ops-trust/portal)
* your pg_hba.conf file should permit the openid 
* Software: nginx, perl-fcgi, Catalyst

Dev cycle is:

* cd ~root/openid, edit, 'make'
* sudo make install; test
* consider restarting apache if you've changed a file it may have cached
* consider installing some database updates
* commit and push; consider going to other portals and doing 'git pull' etc

Install cycle is:

* cd ~root/openid, clone, cp siteconfig.template siteconfig, edit, 'make'
* sudo make install
* do something about nginx
* test

~root/openid is "the" checked out copy of the openid code right now. We are
not yet managing this with 'puppet' because of the 'siteconfig' file. Don't
freak out, just please don't make your own on-host clone and 'make install'
from it without also (a) warning the other sysadmins, (b) committing your
changes and pushing them, (c) pulling your changes into ~root/portal, making,
and 'sudo make install' from there, to ensure that it's really what's running.
