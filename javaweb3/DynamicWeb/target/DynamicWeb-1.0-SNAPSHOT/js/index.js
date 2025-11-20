// 一级菜单点击展开/收起二级菜单
const firstMenuLi = document.querySelectorAll('.first-menu-li');
firstMenuLi.forEach(item => {
    const secondMenu = item.querySelector('.second-menu-ul');
    if (secondMenu) {
        item.addEventListener('click', () => {
            secondMenu.style.display = secondMenu.style.display === 'block' ? 'none' : 'block';
        });
        // 默认展开激活的一级菜单的二级菜单
        if (item.classList.contains('active')) {
            secondMenu.style.display = 'block';
        }
    }
});

// 退出按钮功能
const logoutBtn = document.getElementById('logout-btn');
logoutBtn.addEventListener('click', () => {
    if (confirm('确定要退出系统吗？')) {
        // 发送退出请求到服务器
        fetch('logout', {
            method: 'POST'
        }).then(() => {
            // 跳转到登录页面
            window.location.href = 'login.jsp';
        }).catch(() => {
            // 即使请求失败也跳转到登录页面
            window.location.href = 'login.jsp';
        });
    }
});
