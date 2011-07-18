Mustache = Mustache || {};

Mustache.I18n = {
  messages: {},

  t: function(key) {
    var variables = arguments[1];
    var count     = variables && variables['count'];
    key           = key.trim();

    if (!isNaN(parseInt(count))) {
      key += (count == 1 ? '.one' : '.other');
    }

    var translated = Mustache.I18n.messages[key] || '';

    if (variables) {
      $.each(variables, function(key, value){
        translated = translated.replace(new RegExp('{{' + key + '}}', 'gi'), value);
      });

    }

    return translated;
  }
};

// hack to allow mustache to support extension of contexts when rendering
$.extend(Mustache, {
  context_extensions: {},
  default_renderer: Mustache.to_html,

  to_html: function(template, view, partials, send_fun) {
   return this.default_renderer.call(this.default_renderer, template, this._extend_content(view), partials, send_fun);
  },

  _extend_content: function(context) {
    $.each(this.context_extensions, function(name, func) {
      context[name] = func;
    });
    return context;
  }
});

// i18n extensions used by mustache
Mustache.context_extensions['translate'] = function() {
   return function(content, func) {
     var args = func.call(func, content).trim().split(',');
     return Mustache.I18n.t(args.shift(), eval('(' + args.shift() + ')'));
   };
};