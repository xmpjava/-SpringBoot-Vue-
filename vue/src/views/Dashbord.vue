<template>
  <div>


    <el-row gutter="10" style="margin-bottom: 60px">
      <el-col :span="6">
        <el-card  style="color: #409EFF">
          <div>用户总数</div>
          <div style="padding: 10px 0;text-align: center; font-weight: bold">
            100
          </div>
        </el-card>
      </el-col>
      <el-col :span="6">
        <el-card style="color: #67C23A">
          <div>新增总数</div>
          <div style="padding: 10px 0;text-align: center; font-weight: bold">
            66
          </div>
        </el-card>
      </el-col>
      <el-col :span="6">
        <el-card  style="color: #E6A23C">
          <div>总营业额</div>
          <div style="padding: 10px 0;text-align: center; font-weight: bold">
            $100
          </div>
        </el-card>
      </el-col>
      <el-col :span="6">
        <el-card style="color: #909399">
          <div>VIP总数</div>
          <div style="padding: 10px 0;text-align: center; font-weight: bold">
            88
          </div>
        </el-card>
      </el-col>
    </el-row>



    <el-row>
      <el-col :span="12">
        <div id="main" style="width: 500px; height: 400px"></div>
      </el-col>
      <el-col :span="12">
        <div id="pie" style="width: 500px; height: 400px"></div>
      </el-col>
    </el-row>


  </div>
</template>

<script>
import * as echarts from 'echarts'

export default {
  name: "Home",
  data() {
    return {

    }
  },
  mounted() {   // mounted 是挂载完成后调用的函数

    var option = {
      title: {
        text: '各季度会员数量统计',
        subtext: '趋势图',
        left: 'center'
      },
      xAxis: {
        type: 'category',
        data: ["第一季度", "第二季度", "第三季度", "第四季度"]   // 横坐标
      },
      yAxis: {
        type: 'value'
      },
      series: [
        {
          data: [],
          type: 'line'
        },
        {
          data: [],
          type: 'bar'
        }
      ]
    };
    var chartDom = document.getElementById('main');
    var myChart = echarts.init(chartDom);

    this.request.get('/echarts/members').then(res => {
      //填空
      /*   option.xAxis.data = res.data.x;*/
      option.series[0].data = res.data;
      option.series[1].data = res.data;
      //数据准备完毕，开始绘制图表
      myChart.setOption(option);

      //饼图
      pieOption.series[0].data = [
        {name: "第一季度", value: res.data[0]},
        {name: "第二季度", value: res.data[1]},
        {name: "第三季度", value: res.data[2]},
        {name: "第四季度", value: res.data[3]}
      ]

      pieChart.setOption(pieOption);

    })


    //饼图
    var pieOption = {
      title: {
        text: '各季度会员数量统计',
        subtext: '比例图',
        left: 'center'
      },
      tooltip: {
        trigger: 'item'
      },
      legend: {
        orient: 'vertical',
        left: 'left'
      },
      series: [
        {
          name: 'Access From',
          type: 'pie',
          radius: '65%',      // 半径
          /**
           * 比例等属性
           */
          label:{            //饼图图形上的文本标签
            normal:{
              show:true,
              position:'inner', //标签的位置
              textStyle : {
                fontWeight : 300 ,
                fontSize : 14,    //文字的字体大小
                color: "#fff"
              },
              formatter:'{d}%'
            }
          },


          data: [       //=====>数据填空
            /*{ value: 1048, name: 'Search Engine' },
            { value: 735, name: 'Direct' },
            { value: 580, name: 'Email' },
            { value: 484, name: 'Union Ads' },
            { value: 300, name: 'Video Ads' }*/
          ],
          emphasis: {
            itemStyle: {
              shadowBlur: 10,
              shadowOffsetX: 0,
              shadowColor: 'rgba(0, 0, 0, 0.5)'
            }
          }
        }
      ]
    };
    var pieDom = document.getElementById('pie');
    var pieChart = echarts.init(pieDom);


  }
}
</script>

<style scoped>

</style>