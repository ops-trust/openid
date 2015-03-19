# This file is part of the Ops-T Portal.
# Copyright: Operations Security Administration, Inc.
# All rights reserved.


SUBDIRS= Controller Model View root

all: ${MADE}
	@set -e; for subdir in ${SUBDIRS}; do \
		( set -x && cd $$subdir && ${MAKE} ${MARGS} $@ ); \
	done

clean:; rm -f ${MADE} 
	@set -e; for subdir in ${SUBDIRS}; do \
		( set -x && cd $$subdir && ${MAKE} ${MARGS} $@ ); \
	done

CFLAGS= -O -Wall

# XXX not installing db_migrations or schema.psql since vixie thinks
# those will always be used from this source directory, not in !library!
install: ${MADE} ${OTHER}
	@set -e; for subdir in ${SUBDIRS}; do \
		echo mkdir -p !portal!/openid/lib/openid/$$subdir | \
			perl ../../script/mycat.pl ../../siteconfig | \
			sh -x; \
		set -x && ( cd $$subdir && ${MAKE} ${MARGS} install ); \
	done
	@( echo mkdir -p !portal!/openid/lib/openid; \
	) | \
		perl ../../script/mycat.pl ../../siteconfig | \
		sh -x -e; \
	done
