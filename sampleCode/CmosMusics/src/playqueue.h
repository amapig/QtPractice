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


#ifndef PLAYQUEUE_H
#define PLAYQUEUE_H

#include <QObject>
#include <QList>
#include <QMediaPlaylist>


/* Class for a play queue with history.
 */
class PlayQueue : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString nowPlaying READ nowPlaying NOTIFY itemChanged);
    Q_PROPERTY(QString lable READ lable WRITE setLable);
    Q_PROPERTY(int count READ count);
public:
    explicit PlayQueue(QObject *parent = 0);
    ~PlayQueue();

    void setLable(QString newlable)
    {myLable = newlable;}
    QString lable(){
        return myLable;
    }

    QMediaPlaylist* playlist()
    {
        return m_playlist;
    }

    void append(QUrl url);
    void remove(int nPos);
    void reload(QUrl url);
    QString nowPlaying();

    Q_INVOKABLE void clear()
        { m_playlist->clear(); }
    Q_INVOKABLE void appendPath(QString p)
        { append(QUrl(p)); }
    Q_INVOKABLE void replacePath(QString p)
        { reload(QUrl(p)); }

public slots:
    void previous();
    void next();
    int count(){
        return m_playlist->mediaCount();
    }

    //void skip(int n);
private slots:
    //void handleMediaContentChanged(QMediaContent);

private:
    QString myLable;
    QList<QUrl> history;
    //QList<QUrl> queue;
    QMediaPlaylist *m_playlist;

signals:
    void itemChanged(QString);
};

#endif // PLAYQUEUE_H
