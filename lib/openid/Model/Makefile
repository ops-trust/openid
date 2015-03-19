# This file is part of the Ops-T Portal.
# Copyright: Operations Security Administration, Inc.
# All rights reserved.

MADE= OT_DB.pm

all: ${MADE}

clean:; rm -f ${MADE}

OT_DB.pm: OT_DB.pm.template 
	perl ../../../script/mycat.pl ../../../siteconfig < $@.template > $@

install: ${MADE}
	@( echo mkdir -p !portal!/openid/lib/openid/Model; \
		echo install -m 644 -o !wwwuid! -g !wwwgid! \
                    ${MADE} !portal!/openid/lib/openid/Model; \
	) | \
		perl ../../../script/mycat.pl ../../../siteconfig | \
		sh -x -e; \
	done
