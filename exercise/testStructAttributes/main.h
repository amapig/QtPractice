#ifndef MAIN_H
#define MAIN_H

class CustomPalette : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QColor background READ background WRITE setBackground NOTIFY backgroundChanged)
    Q_PROPERTY(QColor text READ text WRITE setText NOTIFY textChanged)

public:
    CustomPalette() : m_background(Qt::white), m_text(Qt::black) {}
    ~CustomPalette(){};

    QColor background() const { return m_background; }
    void setBackground(const QColor &c) {
        if (c != m_background) {
            m_background = c;
            emit backgroundChanged();
        }
    }

    QColor text() const { return m_text; }
    void setText(const QColor &c) {
        if (c != m_text) {
            m_text = c;
            emit textChanged();
        }
    }

signals:
    void textChanged();
    void backgroundChanged();

private:
    QColor m_background;
    QColor m_text;
};

#endif // MAIN_H
