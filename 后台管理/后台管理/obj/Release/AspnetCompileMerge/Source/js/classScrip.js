function batchInsertClass() {
    var table = document.getElementById('tbRecord1');
    var args = [];
    var flag = 0;
    var rownum = table.rows.length;
    for (var i = 1; i < rownum; i++) {
        args.push(table.rows[i].cells[1].innerHTML);
        if (i == table.rows.length - 1)
            flag = 1;
        后台管理.WebService1.ClassAdd(args, batchInsertsuccess, batchInsertfailed, flag);
        args = [];
    }
}

function batchInsertsuccess() {
    window.alert("成功!");
}

function batchInsertfailed() {
    window.alert("失败!");
}

function OnAdd() {
    form = document.getElementById("formadd");
    inputs = form.getElementsByTagName("input");
    args = [];
    for (var i = 0; i < inputs.length - 1; i++) {
        args.push(inputs[i].value);
    }
    后台管理.WebService1.ClassAdd(args, AddSuccess, AddFailed, args);
}
function AddSuccess(result,args) {
    if (result != "") {
        window.alert("成功！");
        var table = document.getElementById("tbody1");
        var x = table.insertRow(0);
        x.insertCell(0).innerText = args[0];
        x.innerHTML += "<td class='edit'><button id='" + result + "' onclick='OnEdit(this)'><i class='icon-edit bigger-120'></i>编辑</button></td>";
        x.innerHTML += "<td class='delete'><button id='" + result + "' onclick='OnDelete(this)'><i class='icon-trash bigger-120'></i>删除</button></td>"
    }
    
}
function AddFailed() {
    window.alert("失败！");
}

function OnDelete(obj) {
    var tr = obj.parentNode.parentNode;
    var name = tr.cells[0].innerText;
    if (confirm("确定要删除'" + name + "'这一项吗?")) {
        var id = obj.id;
        后台管理.WebService1.ClaDelete(id, Deletesuccess, Deletefailed, tr);
    }
}
function Deletesuccess(result,tr) {
    if (result == true) {
        window.alert("删除成功！");
        tbody = tr.parentNode;
        tbody.removeChild(tr);
    }     
}
function Deletefailed(result) {

}

function OnEdit(obj) {
    var id = obj.id;
    layer.open({
        type: 2,  //1代表 content的值例如：'文本'；2 代表 content的值
        area: ['630px', '460px'],//显示的弹出框的宽度和高度
        title: "提示标题",
        shade: 0.2,//遮罩层透明度
        closeBtn: 1,//0右上角的关闭 x 隐藏掉; 1显示
        shadeClose: true,
        scrollbar: false,//屏蔽浏览器滚动条
        // skin: 'layui-layer-rim', //加上边框
        //content: '<div style="height: 130px; ">conent </div> ',//type=1时
        content: ['classEdit.aspx?id=' + id, 'no'], //这里content是一个URL，如果你不想让iframe出现滚动条，你还可以content: ['http://sentsin.com', 'no'] type=2时

        btn: ['取消'], // 三个按钮的text值
        yes: function (index, layero)//或者使用btn1 按钮1的回调
        {
            //var body = layer.getChildFrame('body', index);
            //var iframeWin = window[layero.find('iframe')[0]['name']]; 
            layer.close(index);
        },
        cancel: function (index)//本身自带关闭弹出框功能 对应btn2的回调函数
        {

        }
    });
}
