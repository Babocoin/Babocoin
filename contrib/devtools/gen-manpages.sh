#!/usr/bin/env bash

export LC_ALL=C
TOPDIR=${TOPDIR:-$(git rev-parse --show-toplevel)}
BUILDDIR=${BUILDDIR:-$TOPDIR}

BINDIR=${BINDIR:-$BUILDDIR/src}
MANDIR=${MANDIR:-$TOPDIR/doc/man}

BABOCOIND=${BABOCOIND:-$BINDIR/babocoind}
BABOCOINCLI=${BABOCOINCLI:-$BINDIR/babocoin-cli}
BABOCOINTX=${BABOCOINTX:-$BINDIR/babocoin-tx}
BABOCOINQT=${BABOCOINQT:-$BINDIR/qt/babocoin-qt}

[ ! -x $BABOCOIND ] && echo "$BABOCOIND not found or not executable." && exit 1

# The autodetected version git tag can screw up manpage output a little bit
BABOVER=($($BABOCOINCLI --version | head -n1 | awk -F'[ -]' '{ print $6, $7 }'))

# Create a footer file with copyright content.
# This gets autodetected fine for babocoind if --version-string is not set,
# but has different outcomes for babocoin-qt and babocoin-cli.
echo "[COPYRIGHT]" > footer.h2m
$BABOCOIND --version | sed -n '1!p' >> footer.h2m

for cmd in $BABOCOIND $BABOCOINCLI $BABOCOINTX $BABOCOINQT; do
  cmdname="${cmd##*/}"
  help2man -N --version-string=${BABOVER[0]} --include=footer.h2m -o ${MANDIR}/${cmdname}.1 ${cmd}
  sed -i "s/\\\-${BABOVER[1]}//g" ${MANDIR}/${cmdname}.1
done

rm -f footer.h2m
