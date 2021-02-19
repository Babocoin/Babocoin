// Copyright (c) 2011-2014 The Bitcoin Core developers
// Distributed under the MIT software license, see the accompanying
// file COPYING or http://www.opensource.org/licenses/mit-license.php.

#ifndef BABOCOIN_QT_BABOCOINADDRESSVALIDATOR_H
#define BABOCOIN_QT_BABOCOINADDRESSVALIDATOR_H

#include <QValidator>

/** Base58 entry widget validator, checks for valid characters and
 * removes some whitespace.
 */
class BabocoinAddressEntryValidator : public QValidator
{
    Q_OBJECT

public:
    explicit BabocoinAddressEntryValidator(QObject *parent);

    State validate(QString &input, int &pos) const;
};

/** Babocoin address widget validator, checks for a valid babocoin address.
 */
class BabocoinAddressCheckValidator : public QValidator
{
    Q_OBJECT

public:
    explicit BabocoinAddressCheckValidator(QObject *parent);

    State validate(QString &input, int &pos) const;
};

#endif // BABOCOIN_QT_BABOCOINADDRESSVALIDATOR_H
