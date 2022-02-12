// ページ遷移後発火
onload = () => {
  sidebarOpenClose();
}
// turbolinksによる遷移後発火
document.addEventListener('turbolinks:load', function() {
  sidebarOpenClose();
});

// sidebarを開閉する関数
sidebarOpenClose = () => {
  var menu = document.getElementById('menu-bar');
  var closeIcon = document.getElementById('close');
  var list = document.getElementById('sp_list');
  menu.addEventListener('click', () => {
    list.classList.remove('-right-sidebar');
    list.classList.remove('opacity-0');
    list.classList.add('right-0');
  });
  closeIcon.addEventListener('click', () => {
    list.classList.remove('right-0');
    list.classList.add('-right-sidebar');
    list.classList.add('opacity-0');
  });
} 