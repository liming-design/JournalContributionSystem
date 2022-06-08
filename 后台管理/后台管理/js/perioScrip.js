var count = 0;
var count2 = 0;
function batchInsert()//批量插入
{
    var table = document.getElementById('tbRecord1');
    var args = [];
    var flag = 0;
    var rownum = table.rows.length;
    var columnum = table.rows[0].cells.length-2;
    for (var i = 1; i < rownum; i++)
    {
        for (var j = 1; j < columnum; j++)
        {
            args.push(table.rows[i].cells[j].innerHTML);
        }     
        if (i == table.rows.length - 1)
            flag = 1;
        后台管理.WebService1.PerioAdd(args, batchAddSuccess, batchAddfailed, flag);        
        args = [];
    }
}
function batchAddSuccess(result, flag) {
    if (result != "")
        count++;
    else
        count2++;
    if (flag == 1) {
        window.alert("成功插入" + count + "条！失败" + count2 + "条！");
    }
}
function batchAddfailed(result) {
    count2++;
}


function selectbyname() {//通过期刊名称查找期刊
    var name = document.getElementById("inputname").value;

    后台管理.WebService1.GetInfobyPerName(name,Selectsuccess,Sellectfailed);

}
function Selectsuccess(result) {
    if (result.length > 0) {
        var table = document.getElementById('tbody1');
        var rowNum = table.rows.length;//删除所有行
        for (i = 0; i < rowNum; i++) {
            table.deleteRow(i);
            rowNum = rowNum - 1;
            i = i - 1;
        }
        var id = result[0];
        var row = table.insertRow(0);
        result.splice(0, 1);//删除0号元素1次，如果未规定此参数，则删除从 index 开始到原数组结尾的所有元素。       
        for (var i = 0; i < result.length-10; i++) {
            var cell = row.insertCell(i);
            cell.innerText = result[i];
        }
        row.innerHTML += "<td class='details'><button id='" + id + "' onclick = 'OnSubject(this)'> <i class='icon - edit bigger - 120'></i>详情</button ></td> ";
        row.innerHTML += "<td class='details'><button id='" + id + "' onclick = 'OnDatabase(this)'> <i class='icon - edit bigger - 120'></i>详情</button ></td> ";
        row.innerHTML += "<td class='edit'><button id='" + id + "' onclick='OnEdit(this)'><i class='icon - edit bigger - 120'></i>编辑</button></td>";
        row.innerHTML += "<td class='delete'><button id='" + id + "' onclick='OnDelete(this)'><i class='icon - trash bigger - 120'></i>删除</button></td>";
        
    }
}
function Sellectfailed(result) {

}

function OnAdd(obj) {
    var form = document.getElementById("form2");
    var inputs = form.getElementsByTagName("input");
    var args = [];
    for (var i = 0; i < inputs.length - 1; i++) {
        args.push(inputs[i].value);
    }
    后台管理.WebService1.PerioAdd(args, AddSuccess, AddFailed)
}
function AddSuccess(result) {
    if (result != "")
        window.alert("成功");
}
function AddFailed() {

}

function OnDelete(obj) {
    var tr = obj.parentNode.parentNode;
    var name = tr.cells[0].innerText;
    if (confirm("确定要删除'" + name + "'这一项吗?")) {
        var id = obj.id;
        后台管理.WebService1.PerioDelete(id, Delsuccess, Delfailed, tr);
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
        title: name+"--编辑",
        shade: 0.2,//遮罩层透明度
        closeBtn: 1,//0右上角的关闭 x 隐藏掉; 1显示
        shadeClose: true,
        scrollbar: false,//屏蔽浏览器滚动条
        // skin: 'layui-layer-rim', //加上边框
        //content: '<div style="height: 130px; ">conent </div> ',//type=1时
        content: ['perioEdit.aspx?id=' + id], //这里content是一个URL，如果你不想让iframe出现滚动条，你还可以content: ['http://sentsin.com', 'no'] type=2时

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

function OnSubject(obj) {
    var id = obj.id;
    var tr = obj.parentNode.parentNode;
    var name = tr.cells[0].innerHTML;
    layer.open({
        type: 2,  //1代表 content的值例如：'文本'；2 代表 content的值
        area: ['630px', '700px'],//显示的弹出框的宽度和高度
        title: name+"--所属学科",
        shade: 0.2,//遮罩层透明度
        closeBtn: 1,//0右上角的关闭 x 隐藏掉; 1显示
        shadeClose: true,
        scrollbar: false,//屏蔽浏览器滚动条
        // skin: 'layui-layer-rim', //加上边框
        //content: '<div style="height: 130px; ">conent </div> ',//type=1时
        content: ['perioSubject.aspx?id=' + id], //这里content是一个URL，如果你不想让iframe出现滚动条，你还可以content: ['http://sentsin.com', 'no'] type=2时

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

function OnDatabase(obj) {
    var id = obj.id;
    var tr = obj.parentNode.parentNode;
    var name = tr.cells[0].innerHTML;
    layer.open({
        type: 2,  //1代表 content的值例如：'文本'；2 代表 content的值
        area: ['830px', '700px'],//显示的弹出框的宽度和高度
        title: name+"--所属数据库",
        shade: 0.2,//遮罩层透明度
        closeBtn: 1,//0右上角的关闭 x 隐藏掉; 1显示
        shadeClose: true,
        scrollbar: false,//屏蔽浏览器滚动条
        // skin: 'layui-layer-rim', //加上边框
        //content: '<div style="height: 130px; ">conent </div> ',//type=1时
        content: ['perioDatabase.aspx?id=' + id], //这里content是一个URL，如果你不想让iframe出现滚动条，你还可以content: ['http://sentsin.com', 'no'] type=2时

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








