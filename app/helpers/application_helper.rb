# frozen_string_literal: true

module ApplicationHelper
  def top_nav
    if current_page?(root_path)
      'bg-opacity-0'
    else
      'shadow-lg bg-opacity-90'
    end
  end

  def default_meta_tags
    {
      site: 'ジロサウナ〜',
      title: '周辺の二郎とサウナを一瞬で検索',
      reverse: true,
      separator: '|',
      description: '「ジロサウナ〜」は、首都圏400件以上の二郎系ラーメンとサウナを網羅した二郎とサウナを同時に探せる検索サイト。マップや店舗から最高の組み合わせを探すことができます。',
      keywords: 'ラーメン, 二郎, 二郎系, サウナ, 銭湯, 整う',
      canonical: request.original_url,
      icon: [
        { href: image_url('logo_main.png'), sizes: '32x32' },
        { href: image_url('logo_main.png'), rel: 'apple-touch-icon', sizes: '180x180', type: 'image/png' }
      ],
      og: {
        site_name: 'ジロサウナ〜',
        title: '周辺の二郎とサウナを一瞬で検索',
        description: '「ジロサウナ〜」は、首都圏400件以上の二郎系ラーメンとサウナを網羅した二郎とサウナを同時に探せる検索サイト。マップや店舗から最高の組み合わせを探すことができます。',
        type: 'website',
        url: request.original_url,
        image: image_url('ogp.png')
      },
      twitter: {
        card: 'summary_large_image',
        site: '@botcher_matsu',
        title: 'ジロサウナ〜 | 周辺の二郎とサウナを一瞬で検索',
        image: image_url('ogp.png')
      }
    }
  end
end
