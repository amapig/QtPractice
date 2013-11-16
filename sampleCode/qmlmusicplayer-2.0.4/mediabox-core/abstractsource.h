/* This file is part of mediabox-core
 * Copyright (C) 2011 Martin Grimme  <martin.grimme _AT_ gmail.com>
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 */


#ifndef ABSTRACTSOURCE_H
#define ABSTRACTSOURCE_H

#include <QObject>
#include "file.h"

namespace content
{

/* Abstract base class for content sources. A content source provides a
 * browsable directory hierarchy of file objects.
 */
class AbstractSource : public QObject
{
    Q_OBJECT

public:
    explicit AbstractSource(QObject *parent = 0);
    virtual content::File::Ptr resolve(QString path) = 0;
    virtual void list(int cookie, QString path) = 0;

signals:
    void newFile(int cookie, content::File::Ptr);

};

}
#endif // ABSTRACTSOURCE_H
