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

.PHONY: help all

all:

help:
	@echo "General targets:"
	@echo "  all (default)  build all targets"
	@echo "  clean          remove temporary files"
	@echo "  realclean      remove temporary and target output files"
	@echo "  distclean      synonym to clean"
	@echo "  info           info on the current project"
