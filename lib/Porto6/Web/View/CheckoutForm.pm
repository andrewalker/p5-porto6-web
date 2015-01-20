package Porto6::Web::View::CheckoutForm;

use utf8;
use Moose;
use namespace::autoclean;
extends 'Catalyst::View';

sub process {
    my ($self, $ctx) = @_;

    my $form = $ctx->stash->{checkout_form};
    $form->attr(style => 'visibility: hidden');

    my $autosubmit = _get_autosubmit();

    $ctx->res->content_type("text/html; charset=utf-8");

    my $html = $form->as_HTML;

    $ctx->res->output( $autosubmit . $html );
}

sub _get_autosubmit {
    my $submit = <<'SUBM';
<p>Redirecionando...</p>
<script type="text/javascript">
window.onload = function () { try { document.forms[0].submit() } catch(e) { document.forms[0].submit.click() } };
</script>
SUBM
    return $submit;
}

__PACKAGE__->meta->make_immutable();

1;
