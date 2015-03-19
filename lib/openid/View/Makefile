# This file is part of the Ops-T Portal.
# Copyright: Operations Security Administration, Inc.
# All rights reserved.

PERL_MODS = HTML_NoWrap.pm HTML.pm

SUBDIRS= Email

all: ${MADE}
	@set -e; for subdir in ${SUBDIRS}; do \
		( set -x && cd $$subdir && ${MAKE} ${MARGS} $@ ); \
	done

clean:; rm -f ${MADE}
	@set -e; for subdir in ${SUBDIRS}; do \
		( set -x && cd $$subdir && ${MAKE} ${MARGS} $@ ); \
	done

install: ${PERL_MODS}
	@set -e; for subdir in ${SUBDIRS}; do \
		echo mkdir -p !portal!/openid/lib/openid/View/$$subdir | \
			perl ../../../script/mycat.pl ../../../siteconfig | \
			sh -x; \
		set -x && ( cd $$subdir && ${MAKE} ${MARGS} install ); \
	done
	@( echo mkdir -p !portal!/openid/lib/openid/View; \
		echo install -m 644 -o !wwwuid! -g !wwwgid! \
                    ${PERL_MODS} !portal!/openid/lib/openid/View; \
	) | \
		perl ../../../script/mycat.pl ../../../siteconfig | \
		sh -x -e; \
	done
