# This file is part of the Ops-T Portal.
# Copyright: Operations Security Administration, Inc.
# All rights reserved.

PERL_MODS = Login.pm  Root.pm

all:

clean:

# XXX not installing db_migrations or schema.psql since vixie thinks
# those will always be used from this source directory, not in !library!
install: ${PERL_MODS}
	@( echo mkdir -p !portal!/openid/lib/openid/Controller; \
		echo install -m 644 -o !wwwuid! -g !wwwgid! \
                    ${PERL_MODS} !portal!/openid/lib/openid/Controller; \
	) | \
		perl ../../../script/mycat.pl ../../../siteconfig | \
		sh -x -e; \
	done
