module namespace page = 'http://basex.org/modules/web-page';

declare namespace web = "http://basex.org/modules/web";

declare
  %rest:path("")
  function page:start()
{
  web:redirect("/static/wp-updates")
};
