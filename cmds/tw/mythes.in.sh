#! /usr/bin/env bash

#  _________________________________________________________________________
# /\                                                                        \
# \_|       ___        __                            _   _                  |
#   |      |_ _|_ __  / _| ___  _ __ _ __ ___   __ _| |_(_) ___  _ __       |
#   |       | || '_ \| |_ / _ \| '__| '_ ` _ \ / _` | __| |/ _ \| '_ \      |
#   |       | || | | |  _| (_) | |  | | | | | | (_| | |_| | (_) | | | |     |
#   |      |___|_| |_|_|  \___/|_|  |_| |_| |_|\__,_|\__|_|\___/|_| |_|     |
#   |                                                                       |
#   |             tw (Translate Word): Human Language Translator            |
#   |              mythes (Mythes) Synonyms Mythes Interface                |
#   |           Copyright (C) 2007 - 2014 Juan Manuel Borges Caño           |
#   |                  The need for an smart, fast and rich                 |
#   |               translation answer inspired this command.               |
#   |                  translate word synonyms help tool                    |
#   |                    _     _                                            |
#   |                   | |   (_) ___ ___ _ __  ___  ___                    |
#   |                   | |   | |/ __/ _ \ '_ \/ __|/ _ \                   |
#   |                   | |___| | (_|  __/ | | \__ \  __/                   |
#   |                   |_____|_|\___\___|_| |_|___/\___|                   |
#   |                                                                       |
#   |  This program is free software: you can redistribute it and/or modify |
#   |  it under the terms of the GNU General Public License as published by |
#   |   the Free Software Foundation, either version 3 of the License, or   |
#   |                  (at your option) any later version.                  |
#   |                                                                       |
#   |    This program is distributed in the hope that it will be useful,    |
#   |     but WITHOUT ANY WARRANTY; without even the implied warranty of    |
#   |     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the     |
#   |              GNU General Public License for more details.             |
#   |                                                                       |
#   |   You should have received a copy of the GNU General Public License   |
#   | along with this program.  If not, see <http://www.gnu.org/licenses/>. |
#   |   ____________________________________________________________________|_
#    \_/______________________________________________________________________/


# The --list option
function mythes_option_list
{
	printf "%s\n" \
	"bg" \
	"ca" \
	"cs" \
	"da" \
	"de" \
	"el" \
	"en" \
	"es" \
	"fr" \
	"ga" \
	"hu" \
	"it" \
	"lb" \
	"lv" \
	"mi" \
	"nb" \
	"ne" \
	"nl" \
	"nn" \
	"pl" \
	"pt" \
	"ro" \
	"ru" \
	"sk" \
	"sl" \
	"sv" \
	"uk"
	exit 0
}

# The --spelling option
function mythes_option_spelling
{
	mythes_spelling="on"
}

# The --speak option
function mythes_option_speak
{
	mythes_speak="on"
}

# This helps adapting naming scheme
function mythes_internal_language
{
	mythes_language=""
	case "$1" in
		"bg") mythes_language="bg_BG";;
		"ca") mythes_language="ca_ES";;
		"cs") mythes_language="cs_CZ";;
		"da") mythes_language="da_DK";;
		"de") mythes_language="de_DE";;
		"el") mythes_language="el_GR";;
		"en") mythes_language="en_US";;
		"es") mythes_language="es_ES";;
		"fr") mythes_language="fr_FR";;
		"ga") mythes_language="ga_IE";;
		"hu") mythes_language="hu_HU";;
		"it") mythes_language="it_IT";;
		"lb") mythes_language="lb_LU";;
		"lv") mythes_language="lv_LV";;
		"mi") mythes_language="mi_NZ";;
		"nb") mythes_language="nb_NO";;
		"ne") mythes_language="ne_NP";;
		"nl") mythes_language="nl_NL";;
		"nn") mythes_language="nn_NO";;
		"pl") mythes_language="pl_PL";;
		"pt") mythes_language="pt_PT";;
		"ro") mythes_language="ro_RO";;
		"ru") mythes_language="ru_RU";;
		"sk") mythes_language="sk_SK";;
		"sl") mythes_language="sl_SI";;
		"sv") mythes_language="sv_SE";;
		"uk") mythes_language="en_GB";;
	esac
	[[ -n "$mythes_language" ]] && printf "%s\n"  "$mythes_language"
}

# This helps adapting antonym
function mythes_antonym
{
	mythes_ant=""
	case "$1" in
		"bg") mythes_ant="антоним";;
		"ca") mythes_ant="antònim";;
		"cs") mythes_ant="antonymum";;
		"da") mythes_ant="antonym";;
		"de") mythes_ant="antonym";;
		"el") mythes_ant="αντίθετο";;
		"en") mythes_ant="antonym";;
		"es") mythes_ant="antónimo";;
		"fr") mythes_ant="antonyme";;
		"ga") mythes_ant="antonym";;
		"hu") mythes_ant="antonímia";;
		"it") mythes_ant="antonimo";;
		"lb") mythes_ant="antonym";;
		"lv") mythes_ant="antonīms";;
		"mi") mythes_ant="antonym";;
		"nb") mythes_ant="antonym";;
		"ne") mythes_ant="antonym";;
		"nl") mythes_ant="antoniem";;
		"nn") mythes_ant="antonym";;
		"pl") mythes_ant="antonim";;
		"pt") mythes_ant="antônimo";;
		"ro") mythes_ant="antonim";;
		"ru") mythes_ant="антоним";;
		"sk") mythes_ant="antonymum";;
		"sl") mythes_ant="protipomenka";;
		"sv") mythes_ant="antonym";;
		"uk") mythes_ant="антонім";;
	esac
	[[ -n "$mythes_ant" ]] && printf "%s\n"  "$mythes_ant"
}

# The spelling helper
function mythes_aspell
{
	if cmd_switch "$mythes_spelling"
	then
		printf "%s\n" "$mythes_input" | aspell -d "$mythes_language" -a  2> /dev/null | sed -ne '/^&/s/^& \([^ ]\+\) [0-9]\+ [0-9]\+: \(.*\)/possible misspelling of \`\1'\'', did you mean: \2?/p' | while read -r mythes_msg
		do
			cmd_warning "$mythes_msg"
		done
	fi
}

# The speak helper
function mythes_espeak
{
	if cmd_switch "$mythes_speak"
	then
		espeak -v "$mythes_language" "$mythes_input" 2> /dev/null
		[[ -n "$mythes_output" ]] && espeak -v "$mythes_language" "$mythes_output" 2> /dev/null
	fi
}

# ... and mythes, the program itself

# The cmd init function
function mythes_init
{
	mythes_speak="off"
	mythes_spelling="off"
}

# The cmd main function
function mythes_main
{
	# This checks for correct input
	if [[ -z "$1" ]]
	then
		cmd_error "unknown action"
	fi


	# This identifies the language
	mythes_language="$1"
	mythes_lang="$(mythes_internal_language "$mythes_language")"
	mythes_idx="/usr/share/mythes/th_${mythes_lang}_v2.idx"
	mythes_dat="/usr/share/mythes/th_${mythes_lang}_v2.dat"

	# This prepares input
	if [[ -z "$2" ]] || [[ "$2" = "-" ]]
	then
		mythes_input="$(cat -)"
	else
		mythes_input="$2"
	fi

	# This does synonyms
	mythes_aspell
	mythes_rawoutput="$(mythes-raw "$mythes_idx" "$mythes_dat" <(printf "%s\n" "$mythes_input") 2> /dev/null)"
	if (( "$?" == "0" ))
	then
		mythes_encoding="$(printf "%s\n" "$mythes_rawoutput" | head -n 1)"
		mythes_output="$(printf "%s\n" "$mythes_rawoutput" | tail -n +2 | sort -u | grep -vi ' ('"$(mythes_antonym "$mythes_language")"')' | sed -e 's/ ([^)]*)$//g')"
		printf "%s\n" "$mythes_output" 
		mythes_espeak &
	else
		cmd_error "access error"
	fi
}

# The cmd fields
cmd_package="[@]pkg[@]"
cmd="mythes"
cmd_name="mythes"
cmd_version="[@]pkgversion[@]"
cmd_description="Synonyms Mythes Interface"
cmd_explanation="mythes is a command that shows synonyms for a given word."
cmd_license="[@]pkglicense[@]"
cmd_homepage="[@]pkghomepage[@]"
cmd_author="[@]pkgauthor[@]"
cmd_email="[@]pkgemail[@]"
cmd_social="[@]pkgsocial[@]"
cmd_blog="[@]pkgblog[@]"
cmd_usage="$cmd [OPTIONS] [DICTIONARY] [TERM]"
cmd_options=("/l/list/list available dictionaries/mythes_option_list/")
if [[ "[@]pkgaspell[@]" == "yes" ]]
then
	cmd_options=("${cmd_options[@]}" "/p/spelling/check the spelling grammar/mythes_option_spelling/")
fi
if [[ "[@]pkgespeak[@]" == "yes" ]]
then
	cmd_options=("${cmd_options[@]}" "/k/speak/speak the text/mythes_option_speak/")
fi
cmd_examples=("$cmd en hello")
cmd_extrahelp="With no term, or when term is -, read standard input."
cmd_extranotes="Machines Content. For more information, check documentation."
cmd_init="mythes_init"
cmd_main="mythes_main"

cmd_datadir="[@]pkgdatadir[@]/$cmd"

# The cmd environment
source "[@]pkgdatadir[@]/cmd.sh"
