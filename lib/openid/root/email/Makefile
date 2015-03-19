# This file is part of the Ops-T Portal.
# Copyright: Operations Security Administration, Inc.
# All rights reserved.


OTHER= ErrorMail.tt2

all: 

clean:;

install: 
	@( echo mkdir -p !portal!/openid/lib/openid/root/email; \
	   echo install -m 644 -o !wwwuid! -g !wwwgid! \
	     ${OTHER} !portal!/openid/lib/openid/root/email; \
	) | \
 	perl ../../../../script/mycat.pl ../../../../siteconfig | \
	  sh -x -e; \
	done

