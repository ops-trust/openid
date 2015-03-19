# This file is part of the Ops-T Portal.
# Copyright: Operations Security Administration, Inc.
# All rights reserved.


OTHER= error.tt form.tt submit.tt

all:

clean:;

install:
	@( echo mkdir -p !portal!/openid/lib/openid/root/templates/login; \
	   echo install -m 644 -o !wwwuid! -g !wwwgid! \
	     ${OTHER} !portal!/openid/lib/openid/root/templates/login; \
	) | \
	perl ../../../../../script/mycat.pl ../../../../../siteconfig | \
	  sh -x -e; \
	done
