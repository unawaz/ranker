var ideas = ["idea 1","idea 2","idea 3"];
var choices = ["default choice a","default choice b"];
var chosen = [];
var ratings = new Map();

function set_rating(s,v) {
  ratings.set(s,v);
}

function get_rating(s) {
  return ratings.get(s);
} 

function new_rateable(s) {
  set_ratings(s,0);
}

// console.log(Elo.getNewRating(1600,1700,1));
// console.log(Elo.getNewRating(1600,1700,0));
// console.log(Elo.getNewRating(1600,1700,0.5));

function change_rating(winner,loser) {
  const w = get_rating(winner);
  const l = get_rating(loser);
  const ww = Elo.getNewRating(w,l,1);
  const ll = Elo.getNewRating(l,w,0);
  set_rating(winner,ww);
  set_rating(loser,ll);
}

function choose(x) {
  const c = x.text();
  const a = $("#compare-a").text();
  const b = $("#compare-b").text();
  chosen.push([c,[a,b]]);
  random_choices();
}

function add_idea(x) { 
 ideas.push(x); 
 $("#rankings ol").append($("<li>").append(x));
} 

function hide_main() {
  $("#new-idea").hide();
  $("#compare").hide();
  $("#rankings").hide();
}

function choices_set(a,b) {
    $("#compare-a").empty();
    $("#compare-b").empty();

    $("#compare-a").append(a);
    $("#compare-b").append(b);
}

function random_item(a) {
  const v = a[Math.floor(Math.random() * a.length)];
  return v
}

function random_choices() {
  const a = random_item(ideas);
  const b = random_item(ideas);
  choices_set(a,b);
}

function show_ideas_list() {
  $("#rankings ol").empty();
  for (s of ideas) {
    $("#rankings ol").append($("<li>").append(s));
  }
}

$(function() {
  $("#new-idea-title").click(function() {
    hide_main();
    $("#new-idea").show();
  });

  $("#compare-title").click(function() {
    hide_main();
    $("#compare").show();
    random_choices();
  });

  $("#rankings-title").click(function() {
    hide_main();
    $("#rankings").show();
    show_ideas_list();
  });

  $("#new-idea-add").click(function() {
    var s = $("#new-idea-text").val();
    $("#new-idea-text").val("");
    add_idea(s);
  });

  $("#compare-a").click(function() { choose($(this)); });
  $("#compare-b").click(function() { choose($(this)); });

  hide_main();
  
});

