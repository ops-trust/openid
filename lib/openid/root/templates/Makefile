# This file is part of the Ops-T Portal.
# Copyright: Operations Security Administration, Inc.
# All rights reserved.


OTHER= about.tt menu.tt mode_associate_enc.tt mode_associate.tt openid-configuration.tt robots.tt server_error.tt well-known.tt xrds.tt

SUBDIRS= login

all: 
	@set -e; for subdir in ${SUBDIRS}; do \
		( set -x && cd $$subdir && ${MAKE} ${MARGS} $@ ); \
	done

clean:;
	@set -e; for subdir in ${SUBDIRS}; do \
		( set -x && cd $$subdir && ${MAKE} ${MARGS} $@ ); \
	done

install: 
	@set -e; for subdir in ${SUBDIRS}; do \
		echo mkdir -p !portal!/openid/lib/openid/root/$$subdir | \
			perl ../../../../script/mycat.pl ../../../../siteconfig | \
			sh -x; \
		set -x && ( cd $$subdir && ${MAKE} ${MARGS} install ); \
	done

	@( echo mkdir -p !portal!/openid/lib/openid/root/templates; \
	   echo install -m 644 -o !wwwuid! -g !wwwgid! \
	     ${OTHER} !portal!/openid/lib/openid/root/templates; \
	) | \
 	perl ../../.././../script/mycat.pl ../../../../siteconfig | \
	  sh -x -e; \
	done

