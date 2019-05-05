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

.PHONY: all info clean realclean distclean
all:

SUBDIRS := \
	instructive-compchess

include mk/help.mk

# Create single goal for a subdir and add that goal as a dependency to
# the global goal. The subdir goal name is "subdir-goal"
define CREATE_GOAL_FOR_SUBDIR
.PHONY: $(1)-$(2)

$(1)-$(2):
	$$(MAKE) -C $(1) $(2)

$(2): $(1)-$(2)

endef

# Create the standard goals for a subdirs and add those as
# dependencies to global targets
define CREATE_SUBDIR_GOALS
$(call CREATE_GOAL_FOR_SUBDIR,$(1),all)
$(call CREATE_GOAL_FOR_SUBDIR,$(1),info)
$(call CREATE_GOAL_FOR_SUBDIR,$(1),clean)
$(call CREATE_GOAL_FOR_SUBDIR,$(1),realclean)
$(call CREATE_GOAL_FOR_SUBDIR,$(1),distclean)
endef

$(eval $(foreach subdir,$(SUBDIRS),$(call CREATE_SUBDIR_GOALS,$(subdir))))
