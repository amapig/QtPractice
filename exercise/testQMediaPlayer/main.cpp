#include "mainwindow.h"
#include "ui_mainwindow.h"
#include <QtMultimediaKit/QMediaPlayer.h>

MainWindow::MainWindow(QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::MainWindow)
{
    ui->setupUi(this);
}

MainWindow::~MainWindow()
{
    delete ui;
}

void MainWindow::playAudioFile(QString localFile)
{
    QMediaPlayer *player; // line 19
    player = new QMediaPlayer; // Line 20
    // line 21
    player->setMedia(QUrl::fromLocalFile(localFile)); // line 22
    player->setVolume(50); // line 23
    player->play(); // line 24
}

void MainWindow::on_playButton1_clicked()
{
    playAudioFile(ui->lineEdit1->text());
}

void MainWindow::on_playButton2_clicked()
{
    playAudioFile(ui->lineEdit2->text());
}
