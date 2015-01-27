package Porto6::Mailer;
use warnings;
use strict;
use utf8;
use feature 'state';
use Email::Sender::Simple;
use Email::MIME;
use Exporter 'import';
use Text::Xslate;
use Porto6::Config;

our @EXPORT = qw/payment_received deposit_request_received/;

sub payment_received {
    my ($info) = @_;

    my $email = Email::MIME->create(
        header_str => [
            To      => "\"$info->{name}\" <$info->{email}>",
            From    => '"Júlia e Lilian" <juliaelilian@seismesesnoporto.ga>',
            Subject => 'Seu lance foi computado!',
        ],
        attributes => {
            content_type => 'text/html',
            charset      => 'UTF-8',
            encoding     => 'quoted-printable',
        },
        body_str => render('payment_received.tx', $info),
    );

    sendmail($email);
}

sub deposit_request_received {
    my ($info) = @_;

    my $email = Email::MIME->create(
        header_str => [
            To      => '"Pagamentos" <pagamento@seismesesnoporto.ga>',
            From    => '"Júlia e Lilian" <juliaelilian@seismesesnoporto.ga>',
            Subject => 'Depósito recebido',
        ],
        attributes => {
            content_type => 'text/html',
            charset      => 'UTF-8',
            encoding     => 'quoted-printable',
        },
        body_str => render('handle_deposit.tx', $info),
    );

    sendmail($email);
}

sub sendmail {
    my ($email) = @_;
    if (exists $ENV{EMAIL_SENDER_TRANSPORT}) {
        Email::Sender::Simple->send($email);
    }
    else {
        warn "Please set EMAIL_SENDER_TRANSPORT. No e-mails will be sent if it is not set.";
    }
}

sub _renderer {
    state $xslate = Text::Xslate->new(path => get_home() . '/root/emails');
    return $xslate;
}

sub render {
    _renderer()->render(@_);
}

1;
