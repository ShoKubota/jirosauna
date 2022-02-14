// ページ遷移後発火
onload = () => {
  topImageSlider();
}
// turbolinksによる遷移後発火
document.addEventListener('turbolinks:load', function() {
  topImageSlider();
});

// sidebarを開閉する関数
var num = 0;

topImageSlider = () => {
  if (num == 3) {
    num = 1;
  } else {
    num ++;
  }
  var topImage = document.getElementById('top-image');
  if (num == 3) {
    topImage.classList.remove(`bg-main-img-${num}`);
    topImage.classList.add(`bg-main-img-1`);
  } else {
    topImage.classList.remove(`bg-main-img-${num}`);
    topImage.classList.add(`bg-main-img-${num ++}`);
  }
  setTimeout("topImageSlider()",1000); 
} 