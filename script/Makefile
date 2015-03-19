# This file is part of the Ops-T Portal.
# Copyright: Operations Security Administration, Inc.
# All rights reserved.


SCRIPTS= openid_cgi.pl openid_create.pl openid_fastcgi.pl openid_server.pl openid_test.pl

MADE= openid_fastcgi.pl

all: ${MADE}

clean:; rm -f ${MADE}

openid_fastcgi.pl: openid_fastcgi.pl.template ../siteconfig
	perl ../script/mycat.pl ../siteconfig < $@.template > $@

# XXX not installing db_migrations or schema.psql since vixie thinks
# those will always be used from this source directory, not in !library!
install: ${SCRIPTS}
	@( echo mkdir -p !portal!/openid/script; \
	   echo install -m 755 -o !wwwuid! -g !wwwgid! \
		${SCRIPTS} !portal!/openid/script; \
	) | \
	perl ../script/mycat.pl ../siteconfig | \
		sh -x -e; \
	done

