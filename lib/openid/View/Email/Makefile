# This file is part of the Ops-T Portal.
# Copyright: Operations Security Administration, Inc.
# All rights reserved.

PERL_MODS = Template.pm

all: 
clean:

install: ${PERL_MODS}
	@( echo mkdir -p !portal!/openid/lib/openid/View/Email; \
		echo install -m 644 -o !wwwuid! -g !wwwgid! \
                    ${PERL_MODS} !portal!/openid/lib/openid/View/Email; \
	) | \
		perl ../../../../script/mycat.pl ../../../../siteconfig | \
		sh -x -e; \
	done
