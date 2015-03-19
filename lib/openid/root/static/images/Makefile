# This file is part of the Ops-T Portal.
# Copyright: Operations Security Administration, Inc.
# All rights reserved.

OTHER= btn_120x50_built.png btn_120x50_powered.png btn_88x31_built.png btn_88x31_powered.png catalyst_logo.png success.png btn_120x50_built_shadow.png btn_120x50_powered_shadow.png btn_88x31_built_shadow.png	btn_88x31_powered_shadow.png error.png notice.png warning.png

all: 

clean:;

install: 
	@( echo mkdir -p !portal!/openid/lib/openid/root/static/images; \
	   echo install -m 644 -o !wwwuid! -g !wwwgid! \
	     ${OTHER} !portal!/openid/lib/openid/root/static/images; \
	) | \
 	perl ../../../../../script/mycat.pl ../../../../../siteconfig | \
	  sh -x -e; \
	done

