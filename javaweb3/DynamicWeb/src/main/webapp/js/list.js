// 搜索与操作
const searchInput = document.querySelector('.search-input');
const searchBtn = document.querySelector('.search-btn');
const container = document.querySelector('.student-card-container');
const addBtn = document.querySelector('.add-btn');
const deleteBtn = document.querySelector('.delete-btn');
const editBtn = document.querySelector('.edit-btn');

// 模态框相关元素
const modal = document.getElementById('student-modal');
const modalCloseBtn = document.getElementById('modal-close-btn');
const modalTitle = document.querySelector('.modal-title');
const studentForm = document.getElementById('student-form');
const confirmBtn = document.getElementById('confirm-btn');
const resetBtn = document.getElementById('reset-btn');

// 表单元素
const formStudentId = document.getElementById('student-id');
const formStudentName = document.getElementById('student-name');
const formGender = document.querySelectorAll('input[name="gender"]');
const formHobbies = document.querySelectorAll('input[name="hobby"]');
const formDepartment = document.getElementById('department');
const formProfile = document.getElementById('profile');
const formHomepage = document.getElementById('homepage');

// 当前编辑模式：'add' 或 'edit'
let currentMode = 'add';
// 当前编辑的卡片元素
let currentEditCard = null;

// 可用的图片数组
const availableImages = ['img/1.jpg', 'img/2.jpg', 'img/3.jpg', 'img/4.jpg', 'img/5.jpg'];

function getCards() {
    return container.querySelectorAll('.student-card');
}

function clearSelection() {
    getCards().forEach(card => {
        card.classList.remove('selected');
        card.style.outline = 'none';
    });
}

function getSelectedCard() {
    return container.querySelector('.student-card.selected');
}

function searchStudent() {
    const keyword = searchInput.value.trim().toLowerCase();
    getCards().forEach(card => {
        const name = card.querySelector('.student-name').textContent.toLowerCase();
        const idText = card.querySelector('.student-id').textContent.toLowerCase();
        if (name.includes(keyword) || idText.includes(keyword)) {
            card.style.display = 'block';
        } else {
            card.style.display = 'none';
        }
    });
}

searchBtn.addEventListener('click', searchStudent);
searchInput.addEventListener('keyup', (e) => {
    if (e.key === 'Enter') searchStudent();
});

// 单选卡片
container.addEventListener('click', (e) => {
    const card = e.target.closest('.student-card');
    if (!card || !container.contains(card)) return;
    if (card.classList.contains('selected')) {
        card.classList.remove('selected');
        card.style.outline = 'none';
        return;
    }
    clearSelection();
    card.classList.add('selected');
    card.style.outline = '3px solid #409eff';
    card.style.outlineOffset = '0';
});

// 模态框相关函数
function openModal(mode = 'add', card = null) {
    currentMode = mode;
    currentEditCard = card;
    
    if (mode === 'add') {
        modalTitle.textContent = '新增学生信息';
        resetForm();
    } else if (mode === 'edit') {
        modalTitle.textContent = '修改学生信息';
        fillFormFromCard(card);
    }
    
    modal.classList.add('show');
}

function closeModal() {
    modal.classList.remove('show');
    resetForm();
    currentEditCard = null;
}

function resetForm() {
    studentForm.reset();
    formStudentId.value = '';
    formStudentName.value = '';
    formGender[0].checked = true; // 默认选择"男"
    formHobbies.forEach(checkbox => checkbox.checked = false);
    formDepartment.value = '无';
    formProfile.value = '';
    formHomepage.value = '';
}

// 从卡片提取数据填充表单
function fillFormFromCard(card) {
    const name = card.querySelector('.student-name').textContent;
    const gender = card.querySelector('.student-gender').textContent;
    const idText = card.querySelector('.student-id').textContent;
    const departmentText = card.querySelector('.student-department').textContent;
    const hobbyText = card.querySelector('.student-hobby').textContent;
    
    // 提取学号
    const studentId = idText.replace('学号：', '');
    formStudentId.value = studentId;
    
    // 填充姓名
    formStudentName.value = name;
    
    // 填充性别
    formGender.forEach(radio => {
        radio.checked = radio.value === gender;
    });
    
    // 填充院系
    const department = departmentText.replace('院系：', '');
    formDepartment.value = department || '无';
    
    // 填充兴趣爱好
    const hobbies = hobbyText.replace('爱好：', '').split('、').map(h => h.trim()).filter(h => h);
    formHobbies.forEach(checkbox => {
        checkbox.checked = hobbies.includes(checkbox.value);
    });
    
    // 填充个人简介（如果存在data属性）
    const profile = card.getAttribute('data-profile') || '';
    formProfile.value = profile;
    
    // 填充个人主页（如果存在data属性）
    const homepage = card.getAttribute('data-homepage') || '';
    formHomepage.value = homepage;
}

// 从表单获取数据
function getFormData() {
    const hobbies = Array.from(formHobbies)
        .filter(checkbox => checkbox.checked)
        .map(checkbox => checkbox.value);
    
    const selectedGender = Array.from(formGender).find(radio => radio.checked);
    
    return {
        id: formStudentId.value.trim(),
        name: formStudentName.value.trim(),
        gender: selectedGender ? selectedGender.value : '男',
        hobbies: hobbies,
        department: formDepartment.value || '无',
        profile: formProfile.value.trim(),
        homepage: formHomepage.value.trim()
    };
}

// 获取随机图片
function getRandomImage() {
    const randomIndex = Math.floor(Math.random() * availableImages.length);
    return availableImages[randomIndex];
}

// 创建学生卡片
function createStudentCard(data) {
    const card = document.createElement('div');
    const genderClass = data.gender === '女' ? 'female' : 'male';
    card.className = `student-card ${genderClass}`;
    
    // 存储额外数据
    card.setAttribute('data-profile', data.profile);
    card.setAttribute('data-homepage', data.homepage);
    
    const hobbiesText = data.hobbies.length > 0 ? data.hobbies.join('、') : '无';
    const imageSrc = getRandomImage();
    
    card.innerHTML = `
        <div class="card-header">
            <span class="student-name">${data.name}</span>
            <span class="student-gender">${data.gender}</span>
        </div>
        <div class="card-content">
            <img src="${imageSrc}" alt="${data.name}" class="student-img">
            <p class="student-id">学号：${data.id}</p>
            <p class="student-department">院系：${data.department}</p>
            <p class="student-hobby">爱好：${hobbiesText}</p>
        </div>
    `;
    
    return card;
}

// 更新学生卡片
function updateStudentCard(card, data) {
    const nameEl = card.querySelector('.student-name');
    const genderEl = card.querySelector('.student-gender');
    const idEl = card.querySelector('.student-id');
    const departmentEl = card.querySelector('.student-department');
    const hobbyEl = card.querySelector('.student-hobby');
    
    nameEl.textContent = data.name;
    genderEl.textContent = data.gender;
    idEl.textContent = `学号：${data.id}`;
    departmentEl.textContent = `院系：${data.department}`;
    
    const hobbiesText = data.hobbies.length > 0 ? data.hobbies.join('、') : '无';
    hobbyEl.textContent = `爱好：${hobbiesText}`;
    
    // 更新性别类
    card.classList.remove('male', 'female');
    card.classList.add(data.gender === '女' ? 'female' : 'male');
    
    // 更新额外数据
    card.setAttribute('data-profile', data.profile);
    card.setAttribute('data-homepage', data.homepage);
}

// 验证表单
function validateForm() {
    if (!formStudentId.value.trim()) {
        alert('请输入学号！');
        formStudentId.focus();
        return false;
    }
    
    if (!formStudentName.value.trim()) {
        alert('请输入姓名！');
        formStudentName.focus();
        return false;
    }
    
    // 检查学号是否已存在（编辑模式下排除当前卡片）
    const existingCards = getCards();
    for (let card of existingCards) {
        if (card === currentEditCard) continue;
        const cardId = card.querySelector('.student-id').textContent.replace('学号：', '');
        if (cardId === formStudentId.value.trim()) {
            alert('该学号已存在！');
            formStudentId.focus();
            return false;
        }
    }
    
    return true;
}

// 确认按钮点击事件 - 修改为通过Servlet处理
confirmBtn.addEventListener('click', () => {
    if (!validateForm()) {
        return;
    }
    
    const formData = getFormData();
    
    // 发送到StudentServlet处理
    const action = currentMode === 'add' ? 'add' : 'update';
    const params = new URLSearchParams();
    params.append('action', action);
    params.append('studentId', formData.id);
    params.append('studentName', formData.name);
    params.append('gender', formData.gender);
    params.append('hobbies', formData.hobbies.join(','));
    params.append('department', formData.department);
    params.append('profile', formData.profile);
    params.append('homepage', formData.homepage);
    
    if (currentMode === 'edit' && currentEditCard) {
        // 编辑模式需要传递原始学号
        const originalId = currentEditCard.querySelector('.student-id').textContent.replace('学号：', '');
        params.append('originalId', originalId);
    }
    
    fetch('student', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: params
    })
    .then(response => response.json())
    .then(data => {
        if (data.success) {
            if (currentMode === 'add') {
                const newCard = createStudentCard(formData);
                container.appendChild(newCard);
                alert('学生信息添加成功！');
            } else if (currentMode === 'edit' && currentEditCard) {
                updateStudentCard(currentEditCard, formData);
                alert('学生信息修改成功！');
            }
            closeModal();
            clearSelection();
        } else {
            alert('操作失败：' + data.message);
        }
    })
    .catch(error => {
        console.error('Error:', error);
        alert('操作失败，请重试！');
    });
});

// 重置按钮点击事件
resetBtn.addEventListener('click', () => {
    if (currentMode === 'add') {
        resetForm();
    } else if (currentMode === 'edit') {
        fillFormFromCard(currentEditCard);
    }
});

// 关闭按钮点击事件
modalCloseBtn.addEventListener('click', closeModal);

// 点击模态框背景关闭
modal.addEventListener('click', (e) => {
    if (e.target === modal) {
        closeModal();
    }
});

// 新增按钮点击事件
addBtn.addEventListener('click', () => {
    openModal('add');
});

// 修改按钮点击事件
editBtn.addEventListener('click', () => {
    const selectedCard = getSelectedCard();
    if (!selectedCard) {
        alert('请先选择要修改的学生！');
        return;
    }
    openModal('edit', selectedCard);
});

// 删除按钮点击事件 - 修改为通过Servlet处理
deleteBtn.addEventListener('click', () => {
    const selectedCard = getSelectedCard();
    if (!selectedCard) {
        alert('请先选择要删除的学生！');
        return;
    }
    
    if (confirm('确定要删除该学生信息吗？')) {
        const studentId = selectedCard.querySelector('.student-id').textContent.replace('学号：', '');
        
        const params = new URLSearchParams();
        params.append('action', 'delete');
        params.append('studentId', studentId);
        
        fetch('student', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
            },
            body: params
        })
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                selectedCard.remove();
                alert('学生信息删除成功！');
                clearSelection();
            } else {
                alert('删除失败：' + data.message);
            }
        })
        .catch(error => {
            console.error('Error:', error);
            alert('删除失败，请重试！');
        });
    }
});
