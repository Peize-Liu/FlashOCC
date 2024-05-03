# FlashOcc: Fast and Memory-Efficient Occupancy Prediction via Channel-to-Height Plugin

<div align="left">
  <img src="figs/performance.png"/>
</div><br/>

## News
- **2024.04.17** Support for ray-iou metric
- **2024.03.22** Release the code for FlashOCCV2
- **2024.02.03** [Release the training code for FlashOcc on UniOcc](https://github.com/drilistbox/FlashOCC_on_UniOcc_and_RenderOCC)
- **2024.01.20** [TensorRT Implement Writen In C++ With Cuda Acceleration](https://github.com/drilistbox/TRT_FlashOcc)
- **2023.12.23** Release the quick testing code via TensorRT in MMDeploy.
- **2023.11.28** Release the training code for FlashOCC.

<!-- - [History](./docs/en/news.md) -->

<!-- ## Introduction -->

[![arXiv](https://img.shields.io/badge/arXiv-Paper-<COLOR>.svg)](https://arxiv.org/abs/2311.12058)

This repository is an official implementation of [FlashOCC](https://arxiv.org/abs/2311.12058) 

<div align="center">
  <img src="figs/overview.png"/>
</div><br/>
Given the capability of mitigating the long-tail deficiencies and intricate-shaped absence prevalent in 3D object detection, occupancy prediction 
has become a pivotal component in autonomous driving systems. However, the procession of three-dimensional voxel-level representations inevitably 
introduces large overhead in both memory and computation, obstructing the deployment of to-date occupancy prediction approaches. In contrast to the 
trend of making the model larger and more complicated, we argue that a desirable framework should be deployment-friendly to diverse chips while 
maintaining high precision. To this end, we propose a plug-and-play paradigm, namely FlashOCC, to consolidate rapid and memory-efficient occupancy 
prediction while maintaining high precision. Particularly, our FlashOCC makes two improvements based on the contemporary voxel-level occupancy prediction 
approaches. Firstly, the features are kept in the BEV, enabling the employment of efficient 2D convolutional layers for feature extraction. Secondly, 
a channel-to-height transformation is introduced to lift the output logits from the BEV into the 3D space. We apply the FlashOCC to diverse occupancy 
prediction baselines on the challenging Occ3D-nuScenes benchmarks and conduct extensive experiments to validate the effectiveness. The results substantiate 
the superiority of our plug-and-play paradigm over previous state-of-the-art methods in terms of precision, runtime efficiency, and memory costs, 
demonstrating its potential for deployment.

## Main Results
### 1. FlashOCCV1
|                                               Config                                                | Backbone | Input <br/>Size |  mIoU   |            FPS<br/>(Hz)            |                                             Flops<br/>(G)                                             |                                           Params<br/>(M)                                           |                                Model                                |                                              Log                                               |
|:---------------------------------------------------------------------------------------------------|:--------:|:----------:|:-------:|:-----------------------------:|:------------------------------------------------------------------------------------------------:|:---------------------------------------------------------------------------------------------:|:-------------------------------------------------------------------:|:----------------------------------------------------------------------------------------------:|
|                 [**BEVDetOCC (1f)**](projects/configs/bevdet_occ/bevdet-occ-r50.py)                 |   R50    |  256x704   |  31.60  |             92.1              |  [241.76](doc/mmdeploy_test.md)   |  [29.02](doc/mmdeploy_test.md)  |                                            [gdrive]()                                            |                                            [log]()                                            |
|                 [**M0: FlashOCC (1f)**](projects/configs/flashocc/flashocc-r50.py)                  |   R50    |  256x704   |  31.95  | [197.6](doc/mmdeploy_test.md) |   [154.1](doc/mmdeploy_test.md)   |  [39.94](doc/mmdeploy_test.md)  |   [gdrive](https://drive.google.com/file/d/14my3jdqiIv6VIrkozQ6-ruEcBOPVlWGJ/view?usp=sharing)   |   [log](https://drive.google.com/file/d/1E-kaHxbTr6s3Qn70vhKpwJM8kejoNFxQ/view?usp=sharing)   |
|                 [**M1: FlashOCC (1f)**](projects/configs/flashocc/flashocc-r50.py)                  |   R50    |  256x704   |  32.08  | [152.7](doc/mmdeploy_test.md) |  [248.57](doc/mmdeploy_test.md)   |  [44.74](doc/mmdeploy_test.md)  | [gdrive](https://drive.google.com/file/d/1k9BzXB2nRyvXhqf7GQx3XNSej6Oq6I-B/view?usp=drive_link)  | [log](https://drive.google.com/file/d/1NRm27wVZMSUylmZxsMedFSLr7729YEAV/view?usp=drive_link)  |
|       [**BEVDetOCC-4D-Stereo (2f)**](projects/configs/bevdet_occ/bevdet-occ-r50-4d-stereo.py)       |   R50    |  256x704   |  36.1   |               -               |                -                |                -                |                [baidu](https://pan.baidu.com/s/1237QyV18zvRJ1pU3YzRItw?pwd=npe1)                 |                [log](https://pan.baidu.com/s/1237QyV18zvRJ1pU3YzRItw?pwd=npe1)                |
|        [**M2:FlashOCC-4D-Stereo (2f)**](projects/configs/flashocc/flashocc-r50-4d-stereo.py)        |   R50    |  256x704   |  37.84  |               -               |                -                |                -                | [gdrive](https://drive.google.com/file/d/12WYaCdoZA8-A6_oh6vdLgOmqyEc3PNCe/view?usp=drive_link)  | [log](https://drive.google.com/file/d/1eYvu9gUSQ7qk7w7lWPLrZMB0O2uKQUk3/view?usp=drive_link)  |
| [**BEVDetOCC-4D-Stereo (2f)**](projects/configs/bevdet_occ/bevdet-occ-stbase-4d-stereo-512x1408.py) |  Swin-T  |  512x1408  |  42.0   |               -               |                -                |                -                |                [baidu](https://pan.baidu.com/s/1237QyV18zvRJ1pU3YzRItw?pwd=npe1)                 |                [log](https://pan.baidu.com/s/1237QyV18zvRJ1pU3YzRItw?pwd=npe1)                |
|  [**M3:FlashOCC-4D-Stereo (2f)**](projects/configs/flashocc/flashocc-stbase-4d-stereo-512x1408.py)  | Swin-T   | 512x1408   |   43.52 |               -               | [1490.77](doc/mmdeploy_test.md) | [144.99](doc/mmdeploy_test.md)  | [gdrive](https://drive.google.com/file/d/1f6E6Bm6enIJETSEbfXs57M0iOUU997kU/view?usp=drive_link)  | [log](https://drive.google.com/file/d/1tch-YK4ROGDGNmDcN5FZnOAvsbHe-iSU/view?usp=drive_link)  |

FPS are tested via TensorRT on 3090 with FP16 precision. Please refer to Tab.2 in paper for the detail model settings for M-number.

### 2. FlashOCCV2
**In FlashOCCV2, we have made the following 3 adjustments to FlashOCC**:
- Without using camera mask for training. This is because its use significantly improves the prediction performance in the visible region, but at the expense of prediction in the invisible region.
- Using category balancing.
- Using stronger loss settings.

**More results for different configurations will be released soon.**

|                                      Config                                      | Backbone | Input <br/>Size  | RayIou | RayPQ |  mIoU  | FPS<br/>(Hz) |         Flops<br/>(G)          |        Params<br/>(M)         |                                              Model                                              |                                             Log                                              |
|:--------------------------------------------------------------------------------|:--------:|:-----------:|:-------:|:------:|:------:|:------------:|:------------------------------:|:-----------------------------:|:-----------------------------------------------------------------------------------------------:|:--------------------------------------------------------------------------------------------:|
|          [**M1: FlashOCC (1f)**](projects/configs/flashocc/flashocc-r50.py)          |   R50    |   256x704   |    -    | - | 15.41  |     25.5     | [248.57](doc/mmdeploy_test.md) | [44.74](doc/mmdeploy_test.md) |                                           [gdrive](https://drive.google.com/file/d/14XsvjSwp-vLpy_eBZzvKo3MAh-YWRHcu/view?usp=drive_link)                                            |                                           [log](https://drive.google.com/file/d/1cTDoauEmjhK9fReLDcA2zPZx4a6X3U1-/view?usp=drive_link)                                            |
| [**FlashOCCV2-Depth-tiny (1f)**](projects/configs/flashoccv2/flashoccv2-r50-depth-tiny.py) |   R50    |   256x704   |  34.57  | - | 28.83  |     29.0     | [175.00](doc/mmdeploy_test.md) | [45.32](doc/mmdeploy_test.md) | [gdrive](https://drive.google.com/file/d/1dqC1UDuVhzs3XWb292j8zWwfc-7pL8oT/view?usp=sharing) | [log](https://drive.google.com/file/d/17z72iyAmR9fE7-O-R_o3Uy07jg83uxCn/view?usp=sharing) |
| [**FlashOCCV2-Depth-tiny-Pano (1f)**](projects/configs/flashoccv2/flashoccv2-r50-depth-tiny-pano.py) |   R50    |   256x704   |  34.81  | - | 29.14  |     -     | [175.00](doc/mmdeploy_test.md) | [45.32](doc/mmdeploy_test.md) | [gdrive](https://drive.google.com/file/d/1dqC1UDuVhzs3XWb292j8zWwfc-7pL8oT/view?usp=sharing) | [log](https://drive.google.com/file/d/17z72iyAmR9fE7-O-R_o3Uy07jg83uxCn/view?usp=sharing) |
| [**FlashOCCV2-Depth (1f)**](projects/configs/flashoccv2/flashoccv2-r50-depth.py) |   R50    |   256x704   |  34.93  | - |  28.91 |     22.6     | [269.47](doc/mmdeploy_test.md) | [50.12](doc/mmdeploy_test.md) | [gdrive](https://drive.google.com/drive/folders/156PrWrBzfZGiNE0INfKwQ4nUcP9Vo8lM?usp=sharing) | [log](https://drive.google.com/drive/folders/156PrWrBzfZGiNE0INfKwQ4nUcP9Vo8lM?usp=sharing) |
| [**FlashOCCV2-Depth-Pano (1f)**](projects/configs/flashoccv2/flashoccv2-r50-depth-pano.py) |   R50    |   256x704   |  35.22  | 12.91 |  29.39 |     -     | [269.47](doc/mmdeploy_test.md) | [50.12](doc/mmdeploy_test.md) | [gdrive](https://drive.google.com/drive/folders/156PrWrBzfZGiNE0INfKwQ4nUcP9Vo8lM?usp=sharing) | [log](https://drive.google.com/drive/folders/156PrWrBzfZGiNE0INfKwQ4nUcP9Vo8lM?usp=sharing) |
| [**FlashOCCV2-4D-Depth (2f)**](projects/configs/flashoccv2/flashoccv2-r50-depth4d.py) |   R50    |   256x704   |  35.99  | - |  29.57 |     22.0     |               -                |               -               | [gdrive](https://drive.google.com/drive/folders/1YOcayapmJNYH7yuiOUOML6rGInCQPMJU?usp=sharing) | [log](https://drive.google.com/drive/folders/1YOcayapmJNYH7yuiOUOML6rGInCQPMJU?usp=sharing) |
| [**FlashOCCV2-4D-Depth-Pano (2f)**](projects/configs/flashoccv2/flashoccv2-r50-depth4d-pano.py) |   R50    |   256x704   |  36.76  | 14.21 |  30.31 |     -     |               -                |               -               | [gdrive](https://drive.google.com/drive/folders/1YOcayapmJNYH7yuiOUOML6rGInCQPMJU?usp=sharing) | [log](https://drive.google.com/drive/folders/1YOcayapmJNYH7yuiOUOML6rGInCQPMJU?usp=sharing) |
| [**FlashOCCV2-4DLongterm-Depth (8f)**](projects/configs/flashoccv2/flashoccv2-r50-depth4d-longterm8f.py) |   R50    |   256x704   |  38.51  | - |  31.49 |     20.3     |               -                |               -               | [gdrive](https://drive.google.com/drive/folders/1ns6f07jNb9WwB1ScJm3tIWdBsU-rh0eS?usp=sharing) | [log](https://drive.google.com/drive/folders/1ns6f07jNb9WwB1ScJm3tIWdBsU-rh0eS?usp=sharing) |
| [**FlashOCCV2-4DLongterm-Depth-Pano (8f)**](projects/configs/flashoccv2/flashoccv2-r50-depth4d-longterm8f.py) |   R50    |   256x704   |  -  | - |  - |     -     |               -                |               -               | [gdrive](https://drive.google.com/drive/folders/1ns6f07jNb9WwB1ScJm3tIWdBsU-rh0eS?usp=sharing) | [log](https://drive.google.com/drive/folders/1ns6f07jNb9WwB1ScJm3tIWdBsU-rh0eS?usp=sharing) |
| [**FlashOCCV2-4DLongterm-Depth (16f)**](projects/configs/flashoccv2/flashoccv2-r50-depth4d-longterm16f.py) |   R50    |   256x704   |  38.31  | - |  31.55 |     19.2     |               -                |               -               | [gdrive](https://drive.google.com/drive/folders/1A0T0VHdPSlWO72WEEUeJvjhj-YpZEFvs?usp=sharing) | [log](https://drive.google.com/drive/folders/1A0T0VHdPSlWO72WEEUeJvjhj-YpZEFvs?usp=sharing) |
| [**FlashOCCV2-4DLongterm-Depth-Pano (16f)**](projects/configs/flashoccv2/flashoccv2-r50-depth4d-longterm16f.py) |   R50    |   256x704   |  -  | - |  - |     -     |               -                |               -               | [gdrive](https://drive.google.com/drive/folders/1A0T0VHdPSlWO72WEEUeJvjhj-YpZEFvs?usp=sharing) | [log](https://drive.google.com/drive/folders/1A0T0VHdPSlWO72WEEUeJvjhj-YpZEFvs?usp=sharing) |

* Please note that the FPS here is measured with Intel(R) Xeon(R) Silver 4210R CPU @ 2.40GHz and NVIDIA RTX3090 GPU (PyTorch fp32 backend).

## Get Started
1. [Environment Setup](doc/install.md)
2. [Model Training](doc/model_training.md)
3. [Quick Test Via TensorRT In MMDeploy](doc/mmdeploy_test.md)

| Backend  | mIOU  | FPS(Hz) |
|----------|-------|---------|
| PyTorch-FP32                                    | 31.95 |    -  |
| TRT-FP32                                        | 30.78 |  96.2 |
| TRT-FP16                                        | 30.78 | 197.6 |
| TRT-FP16+INT8(PTQ)                              | 29.60 | 383.7 |
| TRT-INT8(PTQ)                                   | 29.59 | 397.0 |

4. [Visualization( M3:FlashOCC-4D-Stereo (2f) )](doc/visualization.md)

<div align="center">
  <img src="figs/visualization.png"/>
</div><br/>

A detail video can be found at [baidu](https://pan.baidu.com/s/1xfnFsj5IclpjJxIaOlI6dA?pwd=gype)

5. [TensorRT Implement Writen In C++ With Cuda Acceleration](https://github.com/drilistbox/TRT_FlashOcc)


## Acknowledgement
Many thanks to the authors of [BEVDet](https://github.com/HuangJunJie2017/BEVDet), [FB-BEV](https://github.com/NVlabs/FB-BEV.git),
[RenderOcc](https://github.com/pmj110119/RenderOcc.git) and [SparseBEV](https://github.com/MCG-NJU/SparseBEV.git)

## Bibtex
If this work is helpful for your research, please consider citing the following BibTeX entry.

```
@article{yu2023flashocc,
      title={FlashOcc: Fast and Memory-Efficient Occupancy Prediction via Channel-to-Height Plugin}, 
      author={Zichen Yu and Changyong Shu and Jiajun Deng and Kangjie Lu and Zongdai Liu and Jiangyong Yu and Dawei Yang and Hui Li and Yan Chen},
      year={2023},
      eprint={2311.12058},
      archivePrefix={arXiv},
      primaryClass={cs.CV}
}

```
