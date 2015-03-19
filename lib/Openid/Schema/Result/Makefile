# This file is part of the Ops-T Portal.
# Copyright: Operations Security Administration, Inc.
# All rights reserved.

PERL_MODS= Attestation.pm Language.pm MemberEmail.pm Member.pm MemberVouch.pm SecondFactor.pm WebSession.pm AuditHistory.pm LanguageSkill.pm MemberDetail.pm MemberLanguageSkill.pm MemberState.pm OpenidAssociation.pm SecondFactorType.pm Freemail.pm Mailinglist.pm MemberDetailType.pm MemberMailinglist.pm MemberTrustgroup.pm OpenidSourceCache.pm Trustgroup.pm


all: 

clean:

CFLAGS= -O -Wall

# XXX not installing db_migrations or schema.psql since vixie thinks
# those will always be used from this source directory, not in !library!
install: ${PERL_MODS}
	@( echo mkdir -p !portal!/openid/lib/Openid/Schema/Result; \
	   echo install -m 644 -o !wwwuid! -g !wwwgid! \
		${PERL_MODS} !portal!/openid/lib/Openid/Schema/Result; \
	) | \
		perl ../../../../script/mycat.pl ../../../../siteconfig | \
		sh -x -e; \
	done
