window.App = Ember.Application.create({
  LOG_TRANSITIONS: true,
  LOG_TRANSITIONS_INTERNAL: true,
  LOG_VIEW_LOOKUPS: true
});

App.Router.map(function() {
  this.resource('plans', function() {
    this.route('new');
    this.route('show', {path: '/:plan_id'});
    this.route('edit', {path: '/:plan_id/edit'});
  });
});

// index
App.IndexRoute = Ember.Route.extend({
  redirect: function() {
   this.transitionTo('plans'); 
  }
});

// plans
App.PlanAdapter = DS.RESTAdapter.extend({
  host: 'http://192.168.1.167/api'
});

App.Plan = DS.Model.extend({
    plan_d: DS.attr('date'),
    grade: DS.attr('number'),
    primary_tek_id: DS.belongsTo('tek'),
    secondary_tek_id: DS.belongsTo('tek'),
    ps_id: DS.attr('number'),
    create_d: DS.attr('string'),
    update_d: DS.attr('string')
});

App.PlansIndexRoute = Ember.Route.extend({
    model: function() {
        return this.store.find('plan');
    },
    // setupController: function(controller, model) {
    //     controller.set('model', model);
    // },
});

App.PlansIndexController = Ember.ArrayController.extend({
    sortProperties: ['id'],
    theFilter: "",

    checkFilterMatch: function(theObject, str) {
      var field, match;
      match = false;
      for (field in theObject) {
        if (theObject[field].toString().slice(0, str.length) === str) {
          match = true;
        }
      }
      return match;
    },

    filterPeople: (function() {
      return this.get("arrangedContent").filter((function(_this) {
        return function(theObject, index, enumerable) {
          if (_this.get("theFilter")) {
            return _this.checkFilterMatch(theObject, _this.get("theFilter"));
          } else {
            return true;
          }
        };
      })(this));
    }).property("theFilter", "sortProperties"),

    actions: {
      sortBy: function(property) {
          this.set("sortProperties", [property]);
      }
    }
});

App.PlansIndexView = Ember.View.extend({

});

// teks
App.TekAdapter = DS.RESTAdapter.extend({
  host: 'http://192.168.1.167/api'
});

App.Tek = DS.Model.extend({
    tek: DS.attr('string'),
    grade: DS.attr('number'),
    standard: DS.attr('string'),
    ks: DS.attr('string'),
    se: DS.attr('string')
});


// helpers
Ember.Handlebars.registerBoundHelper('format-date', function(format, date) {
  return moment(date).format(format);
});

// transforms
// App.TimestampdateTransform = DS.Transform.extend({
//   deserialize: function(serialized) {
//     // return moment(serialized).format('MMM DD, YYYY ddd');
//     // return deserialized;
//   },

//   serialize: function(deserialized) {
//     return deserialized;
//   }
// });

