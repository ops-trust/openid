# This file is part of the Ops-T Portal.
# Copyright: Operations Security Administration, Inc.
# All rights reserved.


SUBDIRS= css images

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
		echo mkdir -p !portal!/openid/lib/openid/root/static/$$subdir | \
			perl ../../../../script/mycat.pl ../../../../siteconfig | \
			sh -x; \
		set -x && ( cd $$subdir && ${MAKE} ${MARGS} install ); \
	done

	@( echo mkdir -p !portal!/openid/lib/openid/root/static; ) | \
 	perl ../../../../script/mycat.pl ../../../../siteconfig | \
	  sh -x -e; \
	done

