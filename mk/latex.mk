# skiminki's computer chess studies
# Copyright (C) 2019 Sami Kiminki
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program. If not, see <http://www.gnu.org/licenses/>.

.PHONY: all clean realclean distclean info

AUTODEPENDDIR=.deps
OUTDIR=.tmp

all: $(TARGETS)

clean:
	$(RM) -r $(AUTODEPENDDIR)
	$(RM) -r $(OUTDIR)/

realclean: clean
	$(RM) $(TARGETS)

distclean: realclean

info:
	@echo "Dependencies dir: $(AUTODEPENDDIR)"
	@echo "Temporaries dir:  $(OUTDIR)"
	@echo "Build targets:    $(TARGETS)"

SKIPAUTODEPS:=
SKIPAUTODEPS+=$(if $(findstring clean,$(MAKECMDGOALS)),yes)
SKIPAUTODEPS+=$(if $(findstring info,$(MAKECMDGOALS)),yes)

ifeq "$(strip $(SKIPAUTODEPS))" ""
PHONYVARIABLE:=$(shell mkdir -p $(AUTODEPENDDIR))
include $(shell find $(AUTODEPENDDIR) -name '*.d' -type f)
endif

# The regular latex builder: build until the output has stabilized
COMPILEPDFLATEX-LOOP   := $(BASEDIR)/mk/compile-latex.sh -recorder -interaction batchmode

%.pdf: %.tex
	mkdir -p $(OUTDIR)
	$(COMPILEPDFLATEX-LOOP) $(<F)
	echo "Writing dependency file $(AUTODEPENDDIR)/$(basename $(<F)).d"
	mkdir -p $(AUTODEPENDDIR)
	grep '^INPUT' $(OUTDIR)/$(basename $(<F)).fls | \
		egrep -v '\.(aux)|(bbl)$$' | \
		sed -r 's@^INPUT (\./)?@@' | \
		sed -e 's@//*@/@g' | \
		grep -v '^/' | \
		sort -u | \
		awk 'BEGIN{printf "%s :","$(basename $(<F)).pdf"}{printf " \\\n\t%s", $$0}END{printf "\n\n"}' \
	> $(AUTODEPENDDIR)/$(basename $(<F)).d
