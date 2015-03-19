# This file is part of the Ops-T Portal.
# Copyright: Operations Security Administration, Inc.
# All rights reserved.


OTHER= error.html error_internal.tt2 missing.tt2

all: 

clean:;

install: 
	@( echo mkdir -p !portal!/openid/lib/openid/root/errors; \
	   echo install -m 644 -o !wwwuid! -g !wwwgid! \
	     ${OTHER} !portal!/openid/lib/openid/root/errors; \
	) | \
 	perl ../../../../script/mycat.pl ../../../../siteconfig | \
	  sh -x -e; \
	done

