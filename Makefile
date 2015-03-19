# This file is part of the Ops-T Portal.
# Copyright: Operations Security Administration, Inc.
# All rights reserved.

SUBDIRS= lib script

CONFIGS= openid.conf openid.psgi

all clean: siteconfig
	@set -e; for subdir in ${SUBDIRS}; do \
		( set -x && cd $$subdir && ${MAKE} ${MARGS} $@ ); \
	done

install: all
	@( echo mkdir -p !portal!/openid/; \
           echo install -m 644 -o !wwwuid! -g !wwwgid! \
                ${CONFIGS} !portal!/openid/; \
        ) | \
                perl ./script/mycat.pl ./siteconfig | \
                sh -x -e
	
	@cat ./script/fix-install.sh | \
		perl ./script/mycat.pl ./siteconfig | \
			sh -x
	@set -e; for subdir in ${SUBDIRS}; do \
		echo mkdir -p !portal!/openid/$$subdir | \
			perl ./script/mycat.pl siteconfig | \
			sh -x; \
		set -x && ( cd $$subdir && ${MAKE} ${MARGS} install ); \
	done


siteconfig:
	@echo copy siteconfig from siteconfig.template and localize it
	@exit 1

