# This file is part of the Ops-T Portal.
# Copyright: Operations Security Administration, Inc.
# All rights reserved.

MADE= wrapper.tt2

OTHER= favicon.ico member.tt 

SUBDIRS= email errors static templates

all: ${MADE}
	@set -e; for subdir in ${SUBDIRS}; do \
		( set -x && cd $$subdir && ${MAKE} ${MARGS} $@ ); \
	done

clean:; rm -rf ${MADE}
	@set -e; for subdir in ${SUBDIRS}; do \
		( set -x && cd $$subdir && ${MAKE} ${MARGS} $@ ); \
	done

wrapper.tt2: wrapper.tt2.template ../../../siteconfig
	perl ../../../script/mycat.pl ../../../siteconfig < $@.template > $@

install: 
	@set -e; for subdir in ${SUBDIRS}; do \
		echo mkdir -p !portal!/openid/lib/openid/root/$$subdir | \
			perl ../../../script/mycat.pl ../../../siteconfig | \
			sh -x; \
		set -x && ( cd $$subdir && ${MAKE} ${MARGS} install ); \
	done
	@( echo mkdir -p !portal!/openid/lib/openid/root; \
	   echo install -m 644 -o !wwwuid! -g !wwwgid! \
	     ${OTHER} ${MADE} !portal!/openid/lib/openid/root; \
	) | \
 	perl ../../../script/mycat.pl ../../../siteconfig | \
	  sh -x -e; \
	done

