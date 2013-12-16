#include "colornamesdialog.h"
#include <QLabel>
#include <QHBoxLayout>
#include <QVBoxLayout>

ColorNamesDialog::ColorNamesDialog(QWidget *parent)
    : QDialog(parent)
{
    sourceModel = new QStringListModel(this);
    sourceModel->setStringList(QColor::colorNames());

    proxyModel = new QSortFilterProxyModel(this);
    proxyModel->setSourceModel(sourceModel);
    proxyModel->setFilterKeyColumn(0);

    listView = new QListView;
    listView->setModel(proxyModel);

    QLabel *filterLabel = new QLabel("Filter:", this);
    filterLabel->setFixedWidth(100);
    QLabel *patternLabel = new QLabel("Pattern syntax:", this);
    patternLabel->setFixedWidth(100);

    filterLineEdit = new QLineEdit(this);
    syntaxComboBox = new QComboBox(this);
    syntaxComboBox->addItem("Regular expression", QRegExp::RegExp); // QRegExp::RegExp   为 0
    syntaxComboBox->addItem("Wildcard", QRegExp::Wildcard);         // QRegExp::Wildcard 为 1
    syntaxComboBox->addItem("Fixed string", QRegExp::Wildcard);     // QRegExp::Wildcard 为 2

    QHBoxLayout *filterLayout = new QHBoxLayout;
    filterLayout->addWidget(filterLabel);
    filterLayout->addWidget(filterLineEdit);

    QHBoxLayout *patternLayout = new QHBoxLayout;
    patternLayout->addWidget(patternLabel);
    patternLayout->addWidget(syntaxComboBox);

    QVBoxLayout *mainLayout = new QVBoxLayout;
    mainLayout->addWidget(listView);
    mainLayout->addLayout(filterLayout);
    mainLayout->addLayout(patternLayout);

    setLayout(mainLayout);
    connect(syntaxComboBox, SIGNAL(currentIndexChanged(int)), this, SLOT(reapplyFilter()));
    connect(filterLineEdit, SIGNAL(textChanged(QString)), this, SLOT(reapplyFilter()));
}

ColorNamesDialog::~ColorNamesDialog()
{
}

void ColorNamesDialog::reapplyFilter()
{
    QRegExp::PatternSyntax syntax = QRegExp::PatternSyntax(syntaxComboBox->itemData(
            syntaxComboBox->currentIndex()).toInt());
    QRegExp regExp(filterLineEdit->text(), Qt::CaseInsensitive, syntax);
    proxyModel->setFilterRegExp(regExp);
}
