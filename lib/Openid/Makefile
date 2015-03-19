# This file is part of the Ops-T Portal.
# Copyright: Operations Security Administration, Inc.
# All rights reserved.

PERL_MODS= Schema.pm

SUBDIRS= Schema

all: 
	@set -e; for subdir in ${SUBDIRS}; do \
		( set -x && cd $$subdir && ${MAKE} ${MARGS} $@ ); \
	done

clean:
	@set -e; for subdir in ${SUBDIRS}; do \
		( set -x && cd $$subdir && ${MAKE} ${MARGS} $@ ); \
	done

CFLAGS= -O -Wall

install: 
	@set -e; for subdir in ${SUBDIRS}; do \
		echo mkdir -p !portal!/openid/lib/Openid/$$subdir | \
			perl ../../script/mycat.pl ../../siteconfig | \
			sh -x; \
		set -x && ( cd $$subdir && ${MAKE} ${MARGS} install ); \
	done
	@( echo mkdir -p !portal!/openid/lib/Openid; \
	   echo install -m 644 -o !wwwuid! -g !wwwgid! \
		${PERL_MODS} !portal!/openid/lib/Openid; \
	) | \
		perl ../../script/mycat.pl ../../siteconfig | \
		sh -x -e; \
	done
