function OnAdd(obj) {
    var form = document.getElementById("formadd");
    var inputs = form.getElementsByTagName("input");
    var args = [];
    var pwd = inputs[2].value; var pwd2 = inputs[3].value;
    if (pwd == pwd2 && pwd!="") {
        for (var i = 0; i < inputs.length - 2; i++) {
            args.push(inputs[i].value);
        }
        后台管理.WebService1.UserAdd(args, AddSuccess, AddFailed,args)
    }
    else {
        window.alert("两次密码不一致！");
    }
}
function AddSuccess(result,args) {
    if (result != "") {
        window.alert("成功");
        var table = document.getElementById("tbody1");
        var x = table.insertRow(0);
        for (var i = 0; i < args.length; i++) {
            x.insertCell(i).innerText = args[i];
        }
        x.innerHTML += "<td class='edit'><button id='" + result + "' onclick='OnEdit(this)'><i class='icon-edit bigger-120'></i>编辑</button></td>";
        x.innerHTML += "<td class='delete'><button id='" + result + "' onclick='OnDelete(this)'><i class='icon-trash bigger-120'></i>删除</button></td>"
    }
    else {
        window.alert("重复添加！");
    }
}
function AddFailed() {

}

function OnDelete(obj) {
    var tr = obj.parentNode.parentNode;
    var name = tr.cells[0].innerText;
    if (confirm("确定要删除'" + name + "'这一项吗?")) {
        var id = obj.id;
        后台管理.WebService1.UserDelete(id, Delsuccess, Delfailed, tr);
    }
}
function Delsuccess(result, tr) {
    if (result == true) {
        window.alert("删除成功！");
        tbody = tr.parentNode;
        tbody.removeChild(tr);
    }
}
function Delfailed(result, content) {
    window.alert("删除失败！");
}

function OnEdit(obj) {
    var id = obj.id;
    var tr = obj.parentNode.parentNode;
    var name = tr.cells[0].innerHTML;
    layer.open({
        type: 2,  //1代表 content的值例如：'文本'；2 代表 content的值
        area: ['630px', '700px'],//显示的弹出框的宽度和高度
        title: name + "--编辑",
        shade: 0.2,//遮罩层透明度
        closeBtn: 1,//0右上角的关闭 x 隐藏掉; 1显示
        shadeClose: true,
        scrollbar: false,//屏蔽浏览器滚动条      
        content: ['userEdit.aspx?id=' + id], //这里content是一个URL，如果你不想让iframe出现滚动条，你还可以content: ['http://sentsin.com', 'no'] type=2时

        btn: ['取消'], // 三个按钮的text值
        yes: function (index, layero)//或者使用btn1 按钮1的回调
        {          
            layer.close(index);
        },
        cancel: function (index)//本身自带关闭弹出框功能 对应btn2的回调函数
        {

        }
    });
}
