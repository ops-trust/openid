# This file is part of the Ops-T Portal.
# Copyright: Operations Security Administration, Inc.
# All rights reserved.

PERL_MODS= openid_functions.pm

OTHER= l4p.conf ${PERL_MODS}

MADE= openid.pm 

SUBDIRS= Openid openid

all: ${MADE} ${MADE_SGID}
	@set -e; for subdir in ${SUBDIRS}; do \
		( set -x && cd $$subdir && ${MAKE} ${MARGS} $@ ); \
	done

clean:; rm -f ${MADE}
	@set -e; for subdir in ${SUBDIRS}; do \
		( set -x && cd $$subdir && ${MAKE} ${MARGS} $@ ); \
	done

CFLAGS= -O -Wall

openid.pm: openid.pm.template ../siteconfig
	perl ../script/mycat.pl ../siteconfig < $@.template > $@

l4p.conf: l4p.conf.template ../siteconfig
	perl ../script/mycat.pl ../siteconfig < $@.template > $@

# XXX not installing db_migrations or schema.psql since vixie thinks
# those will always be used from this source directory, not in !library!
install: ${MADE} ${OTHER}
	@set -e; for subdir in ${SUBDIRS}; do \
		echo mkdir -p !portal!/openid/lib/$$subdir | \
			perl ../script/mycat.pl ../siteconfig | \
			sh -x; \
		set -x && ( cd $$subdir && ${MAKE} ${MARGS} install ); \
	done
	@( echo mkdir -p !portal!/openid/lib; \
	   echo install -m 644 -o !wwwuid! -g !wwwgid! \
		${MADE} !portal!/openid/lib; \
	   echo install -m 644 -o !wwwuid! -g !wwwgid! \
	        ${OTHER} !portal!/openid/lib; \
	) | \
		perl ../script/mycat.pl ../siteconfig | \
		sh -x -e; \
	done
