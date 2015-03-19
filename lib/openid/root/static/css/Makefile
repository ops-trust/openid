# This file is part of the Ops-T Portal.
# Copyright: Operations Security Administration, Inc.
# All rights reserved.

OTHER= main.css


all: 

clean:;

install: 
	@( echo mkdir -p !portal!/openid/lib/openid/root/static/css; \
	   echo install -m 644 -o !wwwuid! -g !wwwgid! \
	     ${OTHER} !portal!/openid/lib/openid/root/static/css; \
	) | \
 	perl ../../../../../script/mycat.pl ../../../../../siteconfig | \
	  sh -x -e; \
	done

