<template>
  <div>
    <div style="margin: 10px 0">
      <el-carousel height="450px" :interval="10000">
        <el-carousel-item v-for="item in imgs" :key="item">
          <img :src="item" alt="" style="width: 100%">
        </el-carousel-item>
      </el-carousel>
    </div>

    <div style="margin: 10px 0">
      <el-row :gutter="10">
        <el-col :span="6" v-for="item in files" :key="item.id" style="margin-bottom: 10px">

          <div style="border: 1px solid #ccc; padding-bottom: 10px">
            <img :src="item.url" alt="" style="width: 100%">
            <div style="color: #666; padding: 10px">{{ item.name }}</div>
            <div style="padding: 10px"><el-button type="primary">购买</el-button></div>
          </div>
        </el-col>
      </el-row>
    </div>
  </div>
</template>

<script>
export default {
  name: "FrontHome",
  data() {
    return {
      imgs: [
        'http://rbur3gckq.hn-bkt.clouddn.com/3.jpg?e=1652501303&token=UA9GuPUotZbXQ-daGp0BA8WvTIOjXJ-BFLTQc9Uv:HS1_rKKPrizJwNRPw5KGENY2MPo=',
        'http://rbur3gckq.hn-bkt.clouddn.com/2.jpg?e=1652501303&token=UA9GuPUotZbXQ-daGp0BA8WvTIOjXJ-BFLTQc9Uv:8VG6g5khUE2SJPEGojD4dZTVR3E=',
        'http://rbur3gckq.hn-bkt.clouddn.com/1.jpg?e=1652501303&token=UA9GuPUotZbXQ-daGp0BA8WvTIOjXJ-BFLTQc9Uv:peMPEU3GyAPt7DJJGG4nd-imP2o=',
      ],
      files: []
    }
  },
  created() {
    this.request.get("/echarts/file/front/all").then(res => {
      console.log(res.data)
      this.files = res.data.filter(v => v.type === 'png' || v.type === 'jpg' || v.type === 'webp')
    })
  },
  methods: {

  }
}
</script>

<style>

</style>
