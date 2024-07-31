package com.xxl.job.admin.controller.bean;

import com.xxl.job.admin.core.model.XxlJobGroup;
import com.xxl.job.admin.core.model.XxlJobInfo;
import com.xxl.job.admin.core.model.XxlJobLog;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;

import java.util.List;

@Data
@EqualsAndHashCode(callSuper = true)
@ToString(callSuper = true)
public class XxlJobLogView extends XxlJobLog {
    private String jobDesc;
    private String groupTitle;

    public static XxlJobLogView of(XxlJobLog xxlJobLog, List<XxlJobInfo> jobList, List<XxlJobGroup> groupList) {
        // 转换 xxlJobLog 到 XxlJobLogView
        // 并且自动根据 id 查找 jobDesc 和 groupTitle
        XxlJobLogView xxlJobLogView = new XxlJobLogView();
        xxlJobLogView.setId(xxlJobLog.getId());
        xxlJobLogView.setAlarmStatus(xxlJobLog.getAlarmStatus());
        xxlJobLogView.setExecutorAddress(xxlJobLog.getExecutorAddress());
        xxlJobLogView.setExecutorFailRetryCount(xxlJobLog.getExecutorFailRetryCount());
        xxlJobLogView.setExecutorHandler(xxlJobLog.getExecutorHandler());
        xxlJobLogView.setExecutorParam(xxlJobLog.getExecutorParam());
        xxlJobLogView.setExecutorShardingParam(xxlJobLog.getExecutorShardingParam());
        xxlJobLogView.setHandleCode(xxlJobLog.getHandleCode());
        xxlJobLogView.setHandleMsg(xxlJobLog.getHandleMsg());
        xxlJobLogView.setHandleTime(xxlJobLog.getHandleTime());
        xxlJobLogView.setJobGroup(xxlJobLog.getJobGroup());
        xxlJobLogView.setJobId(xxlJobLog.getJobId());
        xxlJobLogView.setTriggerCode(xxlJobLog.getTriggerCode());
        xxlJobLogView.setTriggerMsg(xxlJobLog.getTriggerMsg());
        xxlJobLogView.setTriggerTime(xxlJobLog.getTriggerTime());
        for (XxlJobInfo job : jobList) {
            if (job.getId() == xxlJobLog.getJobId()) {
                xxlJobLogView.setJobDesc(job.getJobDesc());
                break;
            }
        }
        for (XxlJobGroup group : groupList) {
            if (group.getId() == xxlJobLog.getJobGroup()) {
                xxlJobLogView.setGroupTitle(group.getTitle());
                break;
            }
        }
        return xxlJobLogView;
    }
}
