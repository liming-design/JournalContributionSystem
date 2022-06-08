
function OnDelete(obj)
{
    var tr = obj.parentNode.parentNode;
    var name = tr.cells[0].innerText;
    if (confirm("确定要删除'" + name + "'这一项吗?")) {
        var id = obj.id;     
        后台管理.WebService1.SubDelete(id, Delsuccess, Delfailed,tr );      
    }
}
function OnAdd(obj) {
    var form = obj.parentNode.parentNode.parentNode;  
    var name = form.subName.value;
    if (name != '') {
        var index = form.subClassName.selectedIndex;
        var subClassName = form.subClassName.options[index].innerText;
        var arguments = [name, subClassName];
        后台管理.WebService1.SubAdd(arguments, Addsuccess, Addfailed, arguments);
    }
    else
        window.alert("名称不能为空！");
}
function Addsuccess(result,arguments) {
    if (result != "") {
        //window.alert("添加成功！");
        var table = document.getElementById('tbody1');        
        var x = table.insertRow(0);
        var y = x.insertCell(0);
        var z = x.insertCell(1);
        y.innerText = arguments[0];
        z.innerText = arguments[1];
        x.innerHTML += "<td class='edit'><button id='" + result + "' onclick='OnEdit(this)'><i class='icon - edit bigger - 120'></i>编辑</button></td>"
        x.innerHTML += "<td class='delete'><button id='" + result + "' onclick='OnDelete(this)'><i class='icon - trash bigger - 120'></i>删除</button></td>";
    }
    else {
        //window.alert("添加失败！错误代码：0");
    }
}
function Addfailed() {
    //window.alert("添加失败！错误代码：1");
}
function Delsuccess(result,tr) {
    if (result == true) {
        window.alert("删除成功！");
        tbody = tr.parentNode;
        tbody.removeChild(tr);
    }     
}

function Delfailed(result,content) {
    window.alert("删除失败！");
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
        content: ['subEdit.aspx?id='+id,'no'], //这里content是一个URL，如果你不想让iframe出现滚动条，你还可以content: ['http://sentsin.com', 'no'] type=2时
       
        btn: [ '取消'], // 三个按钮的text值
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


function batchInsertsubject() {
    var table = document.getElementById('tbRecord1');
    var args = [];
    var flag = 0;
    var columnum = table.rows[0].cells.length - 2;
    var rownum = table.rows.length;
    for (var i = 1; i < rownum; i++) {
        for (var j = 1; j < columnum; j++) {
            args.push(table.rows[i].cells[j].innerHTML);
        }     
        if (i == table.rows.length - 1)
            flag = 1;
        后台管理.WebService1.SubAdd(args, Addsuccess, Addfailed, args);
        args = [];
    }

}

function batchInsertSubPerRela() {
    var table = document.getElementById('tbRecord4');
    var args = [];
    var flag = 0;
    var columnum = table.rows[0].cells.length - 2;
    var rownum = table.rows.length;
    for (var i = 1; i < rownum; i++) {
        for (var j = 1; j < columnum; j++) {
            args.push(table.rows[i].cells[j].innerHTML);
        }
        if (i == table.rows.length - 1)
            flag = 1;
        后台管理.WebService1.SubPerioRelaAdd(args, AddrealaSuccess, AddrealaFailed, args);
        args = [];
    }
}

function AddrealaSuccess(result) {

}

function AddrealaFailed(result) {

}