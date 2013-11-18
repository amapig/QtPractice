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


#include "playqueue.h"

PlayQueue::PlayQueue(QObject *parent) :
    QObject(parent)
{
    m_playlist = new QMediaPlaylist;    
}

PlayQueue::~PlayQueue()
{    
    m_playlist->clear();
    delete m_playlist;
}

void PlayQueue::append(QUrl url)
{
    m_playlist->addMedia(url);
}

void PlayQueue::remove(int nPos)
{
    m_playlist->removeMedia(nPos);
}

//load a m3u to playlist
void PlayQueue::reload(QUrl fptr)
{
    Q_UNUSED(fptr)
}

void PlayQueue::previous()
{
    m_playlist->previous();
    //emit itemChanged(m_playlist->currentMedia());
    /*
    if (! history.isEmpty())
    {
        content::File::Ptr fptr = history.takeLast();
        queue.prepend(fptr);
        emit itemChanged(fptr);
    }
    */
}

void PlayQueue::next()
{
    m_playlist->next();
    /*
    if (! queue.isEmpty())
    {
        content::File::Ptr fptr = queue.takeFirst();
        history.append(fptr);
        if (! queue.isEmpty())
            emit itemChanged(queue.first());
    }
    */
}

QString PlayQueue::nowPlaying()
{
    if (! m_playlist->isEmpty())
        return m_playlist->currentMedia().canonicalUrl().toString();
    else
        return "";
}
