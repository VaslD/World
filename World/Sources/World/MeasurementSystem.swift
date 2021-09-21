import Foundation

/// 计量单位制
///
/// 世界上现今通行三种计量单位系统：公制、英制、美制。
public enum MeasurementSystem: String {
    /// 公制系统
    ///
    /// [公制系统 (Metric System)](https://en.wikipedia.org/wiki/Metric_system) 于 18 世纪 90 年代基于法国使用的单位制制定。
    case metric = "Metric"

    /// 英制系统
    ///
    /// [英制单位 (Imperial Units)](https://en.wikipedia.org/wiki/Imperial_units) 为英国于 1826
    /// 年之后重新制定的单位制。此单位制英文原文为帝制单位 (Imperial Units)；事实上只有英国在 1824
    /// 年之前使用的单位制才是真正的[英制单位 (English Units)](https://en.wikipedia.org/wiki/Imperial_units)
    /// 但中文习惯中没有作区分，尽管两种单位制在进制和单位换算上存在区别。
    case imperial = "U.K."

    /// 美制系统
    ///
    /// [美制单位 (U.S. Customary Units)](https://en.wikipedia.org/wiki/United_States_customary_units)
    /// 适用于美国和其他与之有历史渊源的国家，通过改进[英制单位 (English Units)](https://en.wikipedia.org/wiki/Imperial_units)
    /// 后重新制定。
    case customary = "U.S."
}

public extension Locale {
    /// 此语言环境使用的计量单位系统。有关此属性和 `usesMetricSystem`，请查看详细文档。
    ///
    /// `Locale` 提供的 `usesMetricSystem`
    /// 属性仅表示指定语言环境是否存在公制单位，不表示是否完全使用公制系统。例如，英国（大不列颠及北爱尔兰联合王国）在 1995
    /// 年之后混合使用公制和英制单位（政府和公共标志中，重量使用英制单位而长度使用公制单位），因此 `usesMetricSystem` 返回 `true`。
    ///
    /// 此属性通过查询 `NSLocale.Key.measurementSystem` 对应的值并映射到 `MeasurementSystem`
    /// 枚举返回具体的计量单位制，并且包含额外两套处理方式应对可能出现的常量变更。
    var measurementSystem: MeasurementSystem {
        // 无数据的处理方式：使用 usesMetricSystem 决定是否返回 .imperial
        // 全世界只有三个国家使用 .customary，对应返回结果可能有误但不再作特殊处理
        guard let value = (self as NSLocale).object(forKey: NSLocale.Key.measurementSystem) as? String else {
            return self.usesMetricSystem ? .metric : .imperial
        }

        // 系统返回值不在枚举中的处理方式：运行时对比三个使用已知单位制的国家的环境
        guard let system = MeasurementSystem(rawValue: value) else {
            // “公制”以现代法国所用的单位制为基础制定
            let metricSystem =
                (Locale(identifier: "fr-FR") as NSLocale).object(forKey: NSLocale.Key.measurementSystem)
            if value == (metricSystem as? String) {
                return .metric
            }

            // “英制”由英国在 1824 年制定
            let imperialSystem =
                (Locale(identifier: "en-GB") as NSLocale).object(forKey: NSLocale.Key.measurementSystem)
            if value == (imperialSystem as? String) {
                return .imperial
            }

            // “美制”是美国和其他几个国家使用的单位制
            let customarySystem =
                (Locale(identifier: "en-US") as NSLocale).object(forKey: NSLocale.Key.measurementSystem)
            if value == (customarySystem as? String) {
                return .customary
            }

            return self.usesMetricSystem ? .metric : .imperial
        }

        // 无意外则返回枚举
        return system
    }
}
