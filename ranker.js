// var choices = ["default choice a","default choice b"];
// var ratings = new Map();

function set_rating(s,v) {
  localStorage.setItem(s,v);
}

function get_rating(s) {
  return Number(localStorage.getItem(s));
} 

function new_rateable(s) {
  set_rating(s,0);
}

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
  if (c == a) {
    w = a; l = b;
  } else {
    w = b; l = a;
  }
  change_rating(w,l);
  random_choices();
}

function add_idea(x) { 
 new_rateable(x); 
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

function random_idea() {
  // ideas = Array.from(ratings.keys());
  const ideas = Object.keys(localStorage);
  return ideas[Math.floor(Math.random() * ideas.length)];
}

function random_choices() {
  var different = false;
  var a = "";
  var b = "";
  while (different == false) {
    a = random_idea();
    b = random_idea();
    if (a == b) { 
      different = false;
    } else {
      different = true;
    }
  }
  choices_set(a,b);
}

function delete_button(x) {
  var b = $("<button>Delete</button>");
  b.click(function() {
    localStorage.removeItem(x);
    show_ideas_list();
  });
  return b;
}

function show_ideas_list() {
  var l = [...Object.entries(localStorage)];
  l = l.sort((a,b) => b[1] - a[1]); 
  $("#rankings ol").empty();
  for (x of l) {
   $("#rankings ol")
      .append($("<li>")
        .append(x[0])
        .append(delete_button(x[0])));
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

  new_rateable("idea 1");
  new_rateable("idea 2");
  new_rateable("idea 3");

});

