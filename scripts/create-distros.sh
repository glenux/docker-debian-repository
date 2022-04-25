#!/usr/bin/env bash

REPREPRO_DIST="${REPREPRO_OVERRIDE:-/var/lib/reprepro/conf/distributions}"

# path to template file
REPREPRO_DIST_TEMP="/etc/reprepro-distributions.temp"

# Default results to configs/reprepro-distributions
EASYREPO_SUITES="${EASYREPO_SUITES:-unstable,sid/stable,buster/testing,bullseye}"
EASYREPO_ORIGIN="${EASYREPO_ORIGIN:-Test Origin}"
EASYREPO_LABEL="${EASYREPO_LABEL:-Easy Debian Repository}"
EASYREPO_ARCHITECTURES="${EASYREPO_ARCHITECTURES:-i386 amd64 powerpc source}"
EASYREPO_DESCRIPTION="${EASYREPO_LABEL:-Easy Debian Repository}"

# Empty the file
echo -n > $REPREPRO_DIST

# Slash delimited
for i in $(echo ${EASYREPO_SUITES} | sed "s/\// /g")
do
    g=($(echo $i | sed "s/\,/ /g"))
    sed -e "s/{{EASYREPO_ORIGIN}}/${EASYREPO_ORIGIN}/" \
        -e "s/{{EASYREPO_LABEL}}/${EASYREPO_LABEL}/" \
        -e "s/{{EASYREPO_SUITE}}/${g[0]}/" \
        -e "s/{{EASYREPO_CODENAME}}/${g[1]}/" \
        -e "s/{{EASYREPO_ARCHITECTURES}}/${EASYREPO_ARCHITECTURES}/" \
        -e "s/{{EASYREPO_DESCRIPTION}}/${EASYREPO_DESCRIPTION}/" $REPREPRO_DIST_TEMP >> $REPREPRO_DIST
    echo "" >> $REPREPRO_DIST
done

# Remove last line
sed -i '$ d' $REPREPRO_DIST
