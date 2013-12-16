#ifndef COLORNAMESDIALOG_H
#define COLORNAMESDIALOG_H

#include <QDialog>
#include <QSortFilterProxyModel>
#include <QStringListModel>
#include <QListView>
#include <QComboBox>
#include <QLineEdit>

class ColorNamesDialog : public QDialog
{
    Q_OBJECT

public:
    ColorNamesDialog(QWidget *parent = 0);
    ~ColorNamesDialog();
private slots:
    void reapplyFilter();
private:
    QSortFilterProxyModel *proxyModel;
    QStringListModel *sourceModel;
    QListView *listView;
    QComboBox *syntaxComboBox;
    QLineEdit *filterLineEdit;
};

#endif
